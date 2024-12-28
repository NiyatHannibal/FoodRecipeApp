import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/home_screen.dart';
import 'package:foodrecipeapp/view/screen/sign_up_screen.dart';
import 'package:foodrecipeapp/view/widget/custom_Text_Form_fild.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';
import 'package:iconly/iconly.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // The variable related to showing or hiding the text
  bool obscure = false;

  //The variable key related to the txt field
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Welcome Back!",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "Please enter your account here",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        CostomTextFormFild(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the email";
                            } else {
                              return null;
                            }
                          },
                          hint: "Email or phone number",
                          prefixIcon: IconlyBroken.message,
                        ),
                        CostomTextFormFild(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the password";
                            } else {
                              return null;
                            }
                          },
                          obscureText: obscure,
                          hint: "Password",
                          prefixIcon: IconlyBroken.lock,
                          suffixIcon: obscure == true
                              ? IconlyBroken.show
                              : IconlyBroken.hide,
                          onTapSuffixIcon: () {
                            setState(() {});
                            obscure = !obscure;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Forgot password?',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: "Sign In",
                          color: primary,
                          onTap: () {
                            setState(() {
                              if (key.currentState!.validate()) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                  (route) => false,
                                );
                              }
                              ;
                            });
                          },
                        ),
                        Text(
                          'Or continue with',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: SecondaryText),
                        ),
                        CustomButton(
                          onTap: () {},
                          text: "G google",
                          color: Secondary,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Dont have any account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: mainText),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpScreen(),
                                      ));
                                },
                                child: Text(
                                  "Sign Up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: primary),
                                ))
                          ],
                        )
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
