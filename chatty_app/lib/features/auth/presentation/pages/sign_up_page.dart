import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/loader.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmedController.dispose();
  }

  void _onSignUpPressed() {
    if (formKey.currentState!.validate()) {
      String password = passwordController.text;
      String confirmPassword = confirmedController.text;

      if (password == confirmPassword) {
        context.read<AuthBloc>().add(
              SignUpEvent(
                username: usernameController.text.trim(),
                email: emailController.text.trim(),
                password: passwordController.text,
              ),
            );
      } else {
        showSnackBar(context, "The passwords must be the same.");
      }
    }
  }

  void _onSuccessSignUp() {
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmedController.clear();
    showSnackBar(context, "Sign up successfully!");
  }

  void _onReturnPressed() {
    Navigator.pushReplacementNamed(context, Routes.signInRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AssetManager.background,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailureState) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccessState) {
                _onSuccessSignUp();
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return Loader();
              }

              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 20),
                          child: Text(
                            StringManager.appName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: ColorManager.primary,
                                ),
                          ),
                        ),
                      ),

                      // Sized box
                      SizedBox(
                        height: 50,
                      ),

                      // Sign up
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            StringManager.signUp,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: ColorManager.primary,
                                ),
                          ),
                        ),
                      ),

                      // Sized box
                      SizedBox(
                        height: 30,
                      ),

                      // Input email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AuthInput(
                          hintText: StringManager.username,
                          textEditingController: usernameController,
                        ),
                      ),

                      // Sized box
                      SizedBox(
                        height: 30,
                      ),

                      // Input email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AuthInput(
                          hintText: StringManager.email,
                          textEditingController: emailController,
                        ),
                      ),

                      // Sized box
                      SizedBox(
                        height: 30,
                      ),

                      // Input password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AuthInput(
                          hintText: StringManager.password,
                          textEditingController: passwordController,
                          isObscure: true,
                        ),
                      ),

                      // Sized box
                      SizedBox(
                        height: 30,
                      ),

                      // Input confirmed password
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AuthInput(
                          hintText: StringManager.confirmed,
                          textEditingController: confirmedController,
                          isObscure: true,
                        ),
                      ),

                      // Sized box
                      SizedBox(
                        height: 50,
                      ),

                      // Sign up Button
                      RoundedButton(
                        buttonText: StringManager.signUp,
                        backgroundColor: ColorManager.primary50,
                        textColor: Colors.white,
                        onTap: _onSignUpPressed,
                      ),

                      // Sized box
                      SizedBox(
                        height: 20,
                      ),

                      // Back button
                      RoundedButton(
                        buttonText: StringManager.back,
                        backgroundColor: Colors.white.withOpacity(0.5),
                        textColor: ColorManager.primary,
                        onTap: _onReturnPressed,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
