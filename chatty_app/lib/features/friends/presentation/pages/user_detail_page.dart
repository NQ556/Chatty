import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/common/widgets/description.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({
    super.key,
    required this.user,
  });
  final User user;

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  String currentAvatarUrl = StringManager.placeholderUrl;

  void _onReturnPressed() {
    Navigator.of(context).pop();
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
                    buttonText: StringManager.addFriend,
                    backgroundColor: ColorManager.primary50,
                    textColor: Colors.white,
                  ),
                ),

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
