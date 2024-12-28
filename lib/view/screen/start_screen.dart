import 'package:flutter/material.dart';
import 'package:foodrecipeapp/view/screen/sign_in_screen.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(
              "assets/images/Onboarding.png",
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Start Cooking",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: 220,
                    child: Text(
                      "Let’s join our community to cook better food!",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                          (route) => false);
                    },
                    text: "Get Started",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
