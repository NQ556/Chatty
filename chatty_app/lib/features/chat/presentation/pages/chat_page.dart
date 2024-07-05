import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:chatty_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chatty_app/features/chat/presentation/widgets/input_box.dart';
import 'package:chatty_app/features/chat/presentation/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.friendUser,
  });
  final User friendUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textInputController = TextEditingController();
  List<Chat> chats = [];

  void _onReturnPressed() {
    Navigator.of(context).pop();
  }

  void _sendMessage() {
    String message = textInputController.text.trim();
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(
            SendMessageEvent(
              senderId: currentUser.id,
              receiverId: widget.friendUser.id,
              message: message,
            ),
          );

      textInputController.clear();
    }
  }

  bool _isSender(Chat chat) {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    if (currentUser.id != chat.senderId) {
      return false;
    }

    return true;
  }

  void _getAllMessages() {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;
    context.read<ChatBloc>().add(
          GetAllMessagesEvent(
            userId: currentUser.id,
            friendId: widget.friendUser.id,
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _getAllMessages();
  }

  @override
  void dispose() {
    super.dispose();

    textInputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //
            SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                IconButton(
                  onPressed: _onReturnPressed,
                  icon: Icon(
                    Icons.arrow_back_ios_outlined,
                  ),
                ),

                //
                Row(
                  children: [
                    //
                    AvatarPicture(
                        avatarUrl: widget.friendUser.avatarUrl.isEmpty
                            ? StringManager.placeholderUrl
                            : widget.friendUser.avatarUrl,
                        width: 55,
                        height: 55),

                    //
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.friendUser.username,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),

                    //
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.friendUser.isOnline
                            ? Colors.green
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),

                //
                SizedBox(
                  width: 60,
                ),
              ],
            ),

            //
            SizedBox(
              height: 20,
            ),

            //
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocConsumer<ChatBloc, ChatState>(
                  listener: (context, state) {
                    if (state is ChatFailureState) {
                      showSnackBar(context, state.message);
                    } else if (state is SendMessageSuccessState) {
                      chats.add(state.chat);
                    } else if (state is GetAllMessagesSuccessState) {
                      setState(() {
                        chats = state.chats;
                      });
                    }
                  },
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool isSender = _isSender(chats[index]);

                        return Column(
                          crossAxisAlignment: (isSender)
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Message(
                              isSender: isSender,
                              chat: chats[index],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),

            //
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //
                  InputBox(
                    hintText: StringManager.enterText,
                    textEditingController: textInputController,
                  ),

                  //
                  SizedBox(
                    width: 10,
                  ),

                  //
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(
                      Icons.send_outlined,
                    ),
                    iconSize: 35,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageManager {}
