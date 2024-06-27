import 'package:flutter/material.dart';

class AvatarPicture extends StatelessWidget {
  const AvatarPicture({
    super.key,
    required this.avatarUrl,
  });
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(
            avatarUrl,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
