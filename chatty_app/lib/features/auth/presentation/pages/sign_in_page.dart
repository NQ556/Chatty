import 'package:chatty_app/core/common/widgets/rounded_button.dart';
import 'package:chatty_app/core/utils/asset_manager.dart';
import 'package:chatty_app/core/utils/color_manager.dart';
import 'package:chatty_app/core/utils/font_manager.dart';
import 'package:chatty_app/core/utils/route_manager.dart';
import 'package:chatty_app/core/utils/string_manager.dart';
import 'package:chatty_app/features/auth/presentation/widgets/auth_input.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageManager.background,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              // Title
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20, top: 20),
                  child: Text(
                    StringManager.appName,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: ColorManager.primary,
                        ),
                  ),
                ),
              ),

              // Sized box
              SizedBox(
                height: 50,
              ),

              // Sign In
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    StringManager.signIn,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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

              // Forgot password button
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 40, top: 10),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      StringManager.forgotPassword,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManager.primary,
                            fontWeight: FontWeightManager.bold,
                          ),
                    ),
                  ),
                ),
              ),

              // Sized box
              SizedBox(
                height: 30,
              ),

              // Sign in Button
              RoundedButton(
                buttonText: StringManager.signIn,
                backgroundColor: ColorManager.primary50,
                textColor: Colors.white,
              ),

              // Sized box
              SizedBox(
                height: 30,
              ),

              // Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(StringManager.accountQuestion,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManager.primary,
                          )),

                  //
                  SizedBox(
                    width: 10,
                  ),

                  // Sign Up button
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.signUpRoute);
                    },
                    child: Text(
                      StringManager.signUp,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: ColorManager.primary,
                            fontWeight: FontWeightManager.bold,
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
