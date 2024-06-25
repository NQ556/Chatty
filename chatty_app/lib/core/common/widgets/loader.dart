import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorManager.primary,
        backgroundColor: Colors.white,
      ),
    );
  }
}
