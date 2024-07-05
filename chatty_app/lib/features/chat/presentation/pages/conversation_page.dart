import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/search_box.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/chat/domain/entities/conversation.dart';
import 'package:chatty_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:chatty_app/features/chat/presentation/widgets/conversation_item.dart';
import 'package:chatty_app/features/chat/presentation/widgets/empty_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final searchController = TextEditingController();
  List<Conversation> conversations = [];
  bool isFirst = true;

  void _getConversations() {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;
    context.read<ChatBloc>().add(GetConversationsEvent(userId: currentUser.id));
  }

  void _onConversationPressed(User user) {
    Navigator.of(context).pushNamed(
      Routes.chatRoute,
      arguments: user,
    );
  }

  @override
  void initState() {
    super.initState();

    try {
      _getConversations();
    } catch (e) {}
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppUserCubit, AppUserState>(
      listener: (context, state) {
        if (state is AppUserSignedIn) {
          _getConversations();
        }
      },
      builder: (context, state) {
        return SafeArea(
            child: Column(
          children: [
            // Search
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: SearchBox(
                hintText: StringManager.search,
                textEditingController: searchController,
              ),
            ),

            // Conversation list
            BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatFailureState) {
                  showSnackBar(context, state.message);
                } else if (state is GetConversationsSuccessState) {
                  setState(() {
                    conversations = state.conversations;
                  });
                }
              },
              builder: (context, state) {
                return Expanded(
                  child: conversations.isEmpty
                      ? EmptyList()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                            itemCount: conversations.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ConversationItem(
                                conversation: conversations[index],
                                onTap: () {
                                  _onConversationPressed(
                                      conversations[index].friendUser);
                                },
                              );
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ));
      },
    );
  }
}
