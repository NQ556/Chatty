import 'package:chatty_app/core/common/domain/entities/user.dart';

class Conversation {
  final User friendUser;
  final String lastMessage;
  final String timeStamp;
  final bool isCurrentUser;

  Conversation({
    required this.friendUser,
    required this.lastMessage,
    required this.timeStamp,
    required this.isCurrentUser,
  });
}
