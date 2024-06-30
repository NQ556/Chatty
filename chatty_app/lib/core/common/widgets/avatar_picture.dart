import 'package:flutter/material.dart';

class AvatarPicture extends StatelessWidget {
  const AvatarPicture({
    super.key,
    required this.avatarUrl,
    required this.width,
    required this.height,
  });
  final String avatarUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
