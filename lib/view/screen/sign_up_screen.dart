import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/home_screen.dart';
import 'package:foodrecipeapp/view/widget/custom_Text_Form_fild.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';
import 'package:iconly/iconly.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userNameController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';
  final supabase = Supabase.instance.client;

  Future<void> _signUpWithEmailAndPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final email = _emailController.text.trim().toLowerCase();
      final password = _passwordController.text.trim();

      print("Signing up with email: $email");
      print("Password length: ${password.length}");

      try {
        final userResponse = await supabase.auth.signUp(
          email: email,
          password: password,
        );

        if (userResponse.user != null) {
          // Insert user details into the database
          final response = await supabase.from('users').insert({
            'id': userResponse.user!.id,
            'name': _userNameController.text.trim(),
            'email': email,
          });

          if (response.error != null) {
            print('Error inserting data: ${response.error!.message}');
            setState(() {
              _errorMessage = response.error!.message;
            });
          } else {
            // Navigate to the HomeScreen if successful
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }
          }
        } else {
          setState(() {
            _errorMessage = "Sign-up failed. Please try again.";
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = e.toString();
        });
        print("Supabase sign-up error: ${e.toString()}");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userNameController.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Please fill in the form below",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          CostomTextFormFild(
                            controller: _userNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your name";
                              }
                              return null;
                            },
                            hint: "User Name",
                            prefixIcon: IconlyBroken.profile,
                          ),
                          CostomTextFormFild(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              } else if (!RegExp(
                                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                  .hasMatch(value)) {
                                return "Please enter a valid email address";
                              }
                              return null;
                            },
                            hint: "Enter your Email",
                            prefixIcon: IconlyBroken.message,
                          ),
                          CostomTextFormFild(
                            controller: _passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your password";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            obscureText: true,
                            hint: "Password",
                            prefixIcon: IconlyBroken.lock,
                          ),
                          if (_errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                _errorMessage,
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 14),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: "Sign Up",
                            color: primary,
                            onTap: _signUpWithEmailAndPassword,
                            isLoading: _isLoading,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
