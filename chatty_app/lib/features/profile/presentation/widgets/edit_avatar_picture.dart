import 'dart:io';

import 'package:flutter/material.dart';

class EditAvatarPicture extends StatefulWidget {
  const EditAvatarPicture({
    super.key,
    required this.avatarUrl,
    this.onTap,
    this.image,
  });
  final String avatarUrl;
  final VoidCallback? onTap;
  final File? image;

  @override
  State<EditAvatarPicture> createState() => _EditAvatarPictureState();
}

class _EditAvatarPictureState extends State<EditAvatarPicture> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            // Avatar image
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: widget.image != null
                      ? FileImage(widget.image!)
                      : NetworkImage(
                          widget.avatarUrl,
                        ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.9),
                ),
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
