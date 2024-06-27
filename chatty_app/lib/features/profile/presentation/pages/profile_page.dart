import 'package:chatty_app/core/common/cubit/app_user_cubit.dart';
import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/profile/presentation/widgets/avatar_picture.dart';
import 'package:chatty_app/features/profile/presentation/widgets/description.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _onEditPressed() {
    Navigator.of(context).pushNamed(Routes.editRoute);
  }

  void _onSignOutPressed() {
    context.read<AuthBloc>().add(AuthSignOut());
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        (context.read<AppUserCubit>().state as AppUserSignedIn).user;

    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is SignOutSuccess) {
            Navigator.of(context).pushReplacementNamed(Routes.signInRoute);
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
                    avatarUrl:
                        "https://i.pinimg.com/736x/e3/91/b5/e391b58efe027ae5b32616837598316d.jpg",
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
