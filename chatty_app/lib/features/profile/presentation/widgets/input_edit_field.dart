import 'package:flutter/material.dart';

class InputEditField extends StatelessWidget {
  const InputEditField({
    super.key,
    required this.textEditingController,
    required this.label,
    this.isMultipleLine = false,
  });
  final TextEditingController textEditingController;
  final String label;
  final bool isMultipleLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
            ),
          ),
          label: Text(
            label,
          ),
          labelStyle: Theme.of(context).textTheme.bodySmall,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "This field cannot be empty!";
          }
          return null;
        },
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: isMultipleLine ? null : 1,
      ),
    );
  }
}
