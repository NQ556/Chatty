import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/common/widgets/description.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/friends/presentation/bloc/discovery_bloc.dart';
import 'package:chatty_app/features/friends/presentation/widgets/chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({
    super.key,
    required this.user,
    this.isFriend = false,
  });
  final User user;
  final bool isFriend;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  String currentAvatarUrl = StringManager.placeholderUrl;
  bool _isFriend = false;

  @override
  void initState() {
    super.initState();
    _isFriend = widget.isFriend;
  }

  void _onReturnPressed() {
    Navigator.of(context).pop();
  }

  void _onChatPressed() {
    Navigator.of(context).pushNamed(
      Routes.chatRoute,
      arguments: widget.user,
    );
  }

  void _addFriend() {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    context.read<DiscoveryBloc>().add(
          AddFriendEvent(
            currentUserId: currentUser.id,
            friendId: widget.user.id,
            friendUser: widget.user,
          ),
        );

    Navigator.of(context).pop();
  }

  void _removeFriend() async {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    context.read<DiscoveryBloc>().add(
          RemoveFriendEvent(
            currentUserId: currentUser.id,
            friendId: widget.user.id,
            friendUser: widget.user,
          ),
        );

    Navigator.of(context).pop();
  }

  void _onFriendPressed() {
    if (!widget.isFriend) {
      _addFriend();
    } else {
      _removeFriend();
    }

    setState(() {
      _isFriend = !_isFriend;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: _onReturnPressed,
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                      ),
                    ),
                  ),
                ),

                // Avatar picture
                AvatarPicture(
                  avatarUrl: widget.user.avatarUrl.isNotEmpty
                      ? widget.user.avatarUrl
                      : currentAvatarUrl,
                  width: 150,
                  height: 150,
                ),

                //
                SizedBox(
                  height: 10,
                ),

                // Username
                Text(
                  widget.user.username,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeightManager.bold,
                      ),
                ),

                // Email
                Text(
                  widget.user.email,
                  style: Theme.of(context).textTheme.bodySmall,
                ),

                // Add friend button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: RoundedButton(
                    buttonText: _isFriend
                        ? StringManager.unfriend
                        : StringManager.addFriend,
                    backgroundColor: ColorManager.primary50,
                    textColor: Colors.white,
                    onTap: _onFriendPressed,
                  ),
                ),

                //
                _isFriend
                    ? Column(
                        children: [
                          ChatButton(
                            buttonText: StringManager.chat,
                            onTap: _onChatPressed,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    : Container(),

                // Description
                Description(
                  description: widget.user.description.isEmpty
                      ? "No description"
                      : widget.user.description,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
