import 'package:flutter/material.dart';
import 'package:foodrecipeapp/view/screen/new_password_screen.dart';
import 'package:foodrecipeapp/view/widget/custom_Text_Form_fild.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';
import 'package:iconly/iconly.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Password recovery',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Enter your email to recover your password",
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
            CostomTextFormFild(
              hint: "Email or phone number",
              prefixIcon: IconlyBroken.message,
            ),
            CustomButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewPasswordScreen(),
                      ));
                },
                text: "Next"),
          ]),
        ),
      ),
    );
  }
}
