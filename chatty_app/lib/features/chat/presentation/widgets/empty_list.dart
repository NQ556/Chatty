import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AssetManager.chatImage,
          height: 250,
          width: 250,
        ),
        Text(
          StringManager.startChat,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorManager.primary,
                fontWeight: FontWeightManager.bold,
              ),
        )
      ],
    );
  }
}
