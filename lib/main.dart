import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
          //this Font we will use later 'H1'

          displayLarge: TextStyle(
            color: mainText,
            fontFamily: 'Inter',
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),

          //this font we will use later 'H2'

          displayMedium: TextStyle(
            color: mainText,
            fontFamily: 'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
          //this font we will use  later 'H3'

          displaySmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),

          //this font we will use later 'P1'

          bodyLarge: TextStyle(
            color: SecondaryText,
            fontFamily: 'Inter',
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),

          //this font we will use later 'P2'

          bodyMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
          //this font we will use later 'S'
          titleSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          //thus we have added all the fonts used in the project ..
        ),
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(),
    );
  }
}
