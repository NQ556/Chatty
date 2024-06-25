import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({
    super.key,
    required this.hintText,
    required this.textEditingController,
    this.isObscure = false,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: ColorManager.primary,
            ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: ColorManager.primary,
            width: 1.5,
          ),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      obscureText: isObscure,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: ColorManager.primary,
          ),
    );
  }
}
