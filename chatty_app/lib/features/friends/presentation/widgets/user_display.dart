import 'package:chatty_app/core/common/domain/entities/user.dart';
import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({
    super.key,
    required this.user,
    this.onTap,
  });
  final User user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              AvatarPicture(
                avatarUrl: user.avatarUrl.isEmpty
                    ? StringManager.placeholderUrl
                    : user.avatarUrl,
                width: 80,
                height: 80,
              ),

              //
              SizedBox(
                width: 15,
              ),

              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeightManager.bold,
                        ),
                  ),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    user.isOnline
                        ? StringManager.online
                        : StringManager.offline,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeightManager.bold,
                          color: user.isOnline ? Colors.green : Colors.grey,
                        ),
                  ),
                ],
              ),
            ],
          ),

          //
          SizedBox(
            height: 10,
          ),

          // Divider
          Divider(
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
