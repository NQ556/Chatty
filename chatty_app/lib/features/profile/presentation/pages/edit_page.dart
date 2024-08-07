import 'dart:io';
import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/functions/select_image.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/loader.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/profile/presentation/bloc/profile_bloc.dart';
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
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();

  String userId = "";
  String currentAvatarUrl = "";
  String placeholderUrl = StringManager.placeholderUrl;

  File? avatarImage;

  @override
  void initState() {
    super.initState();
    _initUserInfo();
  }

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
    descriptionController.dispose();
  }

  void _initUserInfo() {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;
    usernameController.text = currentUser.username;
    descriptionController.text = currentUser.description.isEmpty
        ? "No description"
        : currentUser.description;
    userId = currentUser.id;

    if (currentUser.avatarUrl.isNotEmpty) {
      currentAvatarUrl = currentUser.avatarUrl;
    }
  }

  void _onReturnPressed() {
    Navigator.of(context).pop();
  }

  void _onSelectImagePressed() async {
    final image = await selectImage();

    if (image != null) {
      setState(() {
        avatarImage = image;
      });
    }
  }

  void _uploadImageToStorage() {
    context.read<ProfileBloc>().add(
          ProfileUploadEvent(
            image: avatarImage!,
            oldUrl: currentAvatarUrl,
          ),
        );
  }

  void _updateUserInfo() {
    if (formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(
            ProfileUpdateEvent(
              userId: userId,
              username: usernameController.text.trim(),
              description: descriptionController.text.trim(),
              avatarUrl: currentAvatarUrl,
            ),
          );
    }
  }

  void _onSavePressed() {
    if (avatarImage != null) {
      _uploadImageToStorage();
    } else {
      _updateUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: formKey,
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is UploadSuccessState) {
                  currentAvatarUrl = state.imageUrl;
                  _updateUserInfo();
                } else if (state is UpdateSuccessState) {
                  showSnackBar(context, "Update successfully!");
                } else if (state is EditFailureState) {
                  showSnackBar(context, state.message);
                }
              },
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return Loader();
                }

                return SingleChildScrollView(
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
                        avatarUrl: currentAvatarUrl.isNotEmpty
                            ? currentAvatarUrl
                            : placeholderUrl,
                        image: avatarImage,
                        onTap: _onSelectImagePressed,
                      ),

                      // Username
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: InputEditField(
                          textEditingController: usernameController,
                          label: StringManager.username,
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
                        onTap: _onSavePressed,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
