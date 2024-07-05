import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/chat/domain/entities/conversation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConversationItem extends StatelessWidget {
  const ConversationItem({
    super.key,
    required this.conversation,
    this.onTap,
  });
  final Conversation conversation;
  final VoidCallback? onTap;

  String _getFormattedTime(String time) {
    try {
      final DateTime timestamp = DateTime.parse(time);

      final DateFormat formatter = DateFormat('h:mm a');

      return formatter.format(timestamp);
    } catch (e) {
      return 'Invalid time';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //
              AvatarPicture(
                avatarUrl: conversation.friendUser.avatarUrl.isEmpty
                    ? StringManager.placeholderUrl
                    : conversation.friendUser.avatarUrl,
                width: 80,
                height: 80,
              ),

              //
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      conversation.friendUser.username,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeightManager.bold,
                          ),
                    ),
                    Row(
                      children: [
                        Text(
                          conversation.isCurrentUser ? "Me:" : "",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeightManager.bold,
                                  ),
                        ),

                        //
                        Row(
                          children: [
                            SizedBox(
                              width: conversation.isCurrentUser ? 150 : 180,
                              child: Text(
                                conversation.lastMessage,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            //
                            SizedBox(
                              width: 5,
                            ),

                            //
                            Text(_getFormattedTime(conversation.timeStamp),
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: conversation.friendUser.isOnline
                      ? Colors.green
                      : Colors.grey,
                ),
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
