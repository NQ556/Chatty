import 'package:chatty_app/core/common/functions/show_snackbar.dart';
import 'package:chatty_app/core/common/widgets/loader.dart';
import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chatty_app/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
  }

  void _onResetPasswordPressed() {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            ResetPasswordEvent(
              email: emailController.text.toString(),
            ),
          );
    }
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
              } else if (state is ResetSuccessState) {
                emailController.clear();
                showSnackBar(context, "Sent reset link successfully!");
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

                      //
                      SizedBox(
                        height: 50,
                      ),

                      // Image
                      Container(
                        child: SvgPicture.asset(
                          AssetManager.forgotImage,
                        ),
                      ),

                      // Instruct text
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          StringManager.forgotText,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: ColorManager.primary,
                                    fontWeight: FontWeightManager.bold,
                                  ),
                        ),
                      ),

                      // Input email
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: AuthInput(
                          hintText: StringManager.email,
                          textEditingController: emailController,
                        ),
                      ),

                      //
                      SizedBox(
                        height: 60,
                      ),

                      // Confirm Button
                      RoundedButton(
                        buttonText: StringManager.confirm,
                        backgroundColor: ColorManager.primary50,
                        textColor: Colors.white,
                        onTap: _onResetPasswordPressed,
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
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.signInRoute);
                        },
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
