class FriendRequest {
  static const String PENDING = "pending";
  static const String ACCEPTED = "accepted";
  static const String DENIED = "denied";

  final String sendId;
  final String receivedId;
  final String status;

  FriendRequest({
    required this.sendId,
    required this.receivedId,
    required this.status,
  });
}
