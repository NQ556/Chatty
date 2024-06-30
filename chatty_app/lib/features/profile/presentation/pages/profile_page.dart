import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/core/common/widgets/avatar_picture.dart';
import 'package:chatty_app/features/profile/presentation/widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentAvatarUrl = StringManager.placeholderUrl;

  void _onEditPressed() {
    Navigator.pushNamed(context, Routes.editRoute);
  }

  void _onSignOutPressed() {
    context.read<AuthBloc>().add(SignOutEvent());
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailureState) {
            showSnackBar(context, state.message);
          } else if (state is SignOutSuccessState) {
            //_tmp();
            Navigator.pushReplacementNamed(context, Routes.signInRoute);
          }
        },
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  SizedBox(
                    height: 30,
                  ),

                  // Avatar picture
                  AvatarPicture(
                    avatarUrl: currentUser.avatarUrl.isNotEmpty
                        ? currentUser.avatarUrl
                        : currentAvatarUrl,
                    width: 150,
                    height: 150,
                  ),

                  //
                  SizedBox(
                    height: 10,
                  ),

                  // Username
                  Text(
                    currentUser.username,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeightManager.bold,
                        ),
                  ),

                  // Email
                  Text(
                    currentUser.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),

                  // Edit button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: RoundedButton(
                      buttonText: StringManager.edit,
                      backgroundColor: ColorManager.primary50,
                      textColor: Colors.white,
                      onTap: _onEditPressed,
                    ),
                  ),

                  // Description
                  Description(
                    description: currentUser.description.isEmpty
                        ? "No description"
                        : currentUser.description,
                  ),

                  //Sign out button
                  TextButton(
                    onPressed: _onSignOutPressed,
                    child: Text(
                      StringManager.signOut,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorManager.primary,
                            fontWeight: FontWeightManager.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
