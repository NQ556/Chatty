import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.hintText,
    required this.textEditingController,
  });

  final String hintText;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodySmall,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
          ),
        ),
        suffixIconConstraints: BoxConstraints(
          minHeight: 30,
          minWidth: 30,
        ),
        suffixIcon: SvgPicture.asset(
          AssetManager.searchIcon,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}
