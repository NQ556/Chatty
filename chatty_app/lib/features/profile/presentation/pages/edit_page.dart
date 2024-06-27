import 'dart:io';

import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/functions/select_image.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/navigation/presentation/bloc/nav_bloc.dart';
import 'package:chatty_app/features/profile/presentation/widgets/edit_avatar_picture.dart';
import 'package:chatty_app/features/profile/presentation/widgets/input_edit_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  File? avatarImage;

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
  }

  void _onReturnPressed() {
    Navigator.of(context).pop();
    context.read<NavBloc>().add(
          NavProfile(),
        );
  }

  void _onSelectImagePressed() async {
    final image = await selectImage();

    if (image != null) {
      setState(() {
        avatarImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;
    usernameController.text = currentUser.username;
    emailController.text = currentUser.email;
    descriptionController.text = currentUser.description.isEmpty
        ? "No description"
        : currentUser.description;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back button
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: _onReturnPressed,
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                      ),
                    ),
                  ),
                ),

                // Avatar picture
                EditAvatarPicture(
                  avatarUrl:
                      "https://i.pinimg.com/736x/e3/91/b5/e391b58efe027ae5b32616837598316d.jpg",
                  image: avatarImage,
                  onTap: _onSelectImagePressed,
                ),

                SizedBox(
                  height: 30,
                ),

                // Username
                InputEditField(
                  textEditingController: usernameController,
                  label: StringManager.username,
                ),

                // Email
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                  ),
                  child: InputEditField(
                    textEditingController: emailController,
                    label: StringManager.email,
                  ),
                ),

                // Description
                InputEditField(
                  textEditingController: descriptionController,
                  label: StringManager.description,
                  isMultipleLine: true,
                ),

                //
                SizedBox(
                  height: 50,
                ),

                // Save button
                RoundedButton(
                  buttonText: StringManager.save,
                  backgroundColor: ColorManager.primary50,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
