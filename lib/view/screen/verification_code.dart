import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/password_recovery_screen.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';

import '../widget/custom_pin_code.dart';

class VerificationCode extends StatelessWidget {
  const VerificationCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "check your email",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "We.ve sent the code to your email",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                CustomPinCode(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "code expires in  ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      '3:10',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Secondary),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasswordRecoveryScreen(),
                          ));
                    },
                    text: "Verify"),
                CustomButton(
                  onTap: () {},
                  text: "Send again",
                  colorBorder: SecondaryText,
                  color: Colors.white24,
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
