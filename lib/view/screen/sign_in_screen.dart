import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/home_screen.dart';
import 'package:foodrecipeapp/view/widget/custom_Text_Form_fild.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';
import 'package:iconly/iconly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obscure = false;
  final key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  final supabase = Supabase.instance.client;

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = ''; // Reset any previous error message
    });
    try {
      if (key.currentState!.validate()) {
        await supabase.auth.signInWithPassword(
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text.trim(),
        );

        if (mounted) {
          // Check if the widget is still in the widget tree
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        }
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      print("Supabase sign-in error: ${e.toString()}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.clear();
    _passwordController.clear();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                          controller: _emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter the email";
                            } else {
                              return null;
                            }
                          },
                          hint: "Please enter your Email ",
                          prefixIcon: IconlyBroken.message,
                        ),
                        CostomTextFormFild(
                          controller: _passwordController,
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
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
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
                            _signInWithEmailAndPassword();
                          },
                          isLoading: _isLoading,
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
