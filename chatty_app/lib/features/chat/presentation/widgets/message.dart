import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/chat/domain/entities/chat.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Message extends StatelessWidget {
  const Message({
    super.key,
    this.isSender = true,
    required this.chat,
  });
  final bool isSender;
  final Chat chat;

  String _getFormattedTime(DateTime timestamp) {
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        //
        !isSender
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: AvatarPicture(
                  avatarUrl: StringManager.placeholderUrl,
                  width: 40,
                  height: 40,
                ),
              )
            : Container(),

        //
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //
            Container(
              constraints: BoxConstraints(maxWidth: 180),
              decoration: BoxDecoration(
                color:
                    isSender ? ColorManager.lightGreen : ColorManager.lightGrey,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Text(
                  chat.message,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            //
            SizedBox(
              height: 5,
            ),

            //
            Text(
              _getFormattedTime(chat.timeSent),
              style: Theme.of(context).textTheme.displaySmall,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ],
    );
  }
}
