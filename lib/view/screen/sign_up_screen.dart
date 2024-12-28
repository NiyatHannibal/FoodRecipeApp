import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/verification_code.dart';
import 'package:foodrecipeapp/view/widget/custom_Text_Form_fild.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';
import 'package:iconly/iconly.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // The variable related to showing or hiding the text
  bool obscure = false;

  //The variable key related to the txt field
  final key = GlobalKey<FormState>();

  //The validator key related to the text field
  bool _contansANumber = false;
  bool _numberofDigits = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        reverse: true,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Welcome",
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
                        onChanged: (value) {
                          setState(() {
                            _numberofDigits = value.length < 6 ? false : true;
                          });
                        },
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
                      // Part about password terms
                      passwordTerms(
                          contains: _contansANumber, atleast6: _numberofDigits),
                    ],
                  ),
                ),
                CustomButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationCode(),
                          ));
                      setState(() {
                        key.currentState!.validate();
                      });
                    },
                    text: "Sign Up")
              ],
            ),
          ),
        ),
      ),
    ));
  }

  // Part about password terms
  passwordTerms({
    required bool contains,
    required bool atleast6,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Your password must contain :",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: mainText),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: atleast6 == false ? outline : Color(0xFFE3FFF1),
              child: Icon(
                Icons.done,
                size: 12,
                color: atleast6 == false ? SecondaryText : primary,
              ),
            ),
            Text(
              "  Atleast 6 characters",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: atleast6 == false ? SecondaryText : mainText),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: contains == false ? outline : Color(0xFFE3FFF1),
              child: Icon(
                Icons.done,
                size: 12,
                color: contains == false ? SecondaryText : primary,
              ),
            ),
            Text(
              "  Contains a number",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: contains == false ? SecondaryText : mainText),
            )
          ],
        ),
      ],
    );
  }
}
