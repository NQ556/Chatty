import 'package:chatty_app/core/common/entities/user.dart';
import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
