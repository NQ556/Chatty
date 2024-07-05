import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.hintText,
    required this.textEditingController,
  });
  final String hintText;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black)),
      ),
    );
  }
}
