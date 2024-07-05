import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatButton extends StatelessWidget {
  const ChatButton({
    super.key,
    required this.buttonText,
    this.onTap,
  });
  final String buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(AssetManager.chatIcon),
        ],
      ),
    );
  }
}
