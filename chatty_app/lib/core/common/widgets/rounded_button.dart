import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.buttonText,
    this.onTap,
    required this.backgroundColor,
    required this.textColor,
  });

  final String buttonText;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Container(
        width: 200,
        child: Center(
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: textColor,
                ),
          ),
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
    );
  }
}
