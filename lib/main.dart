import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/start_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url:
        'https://nqklowtyxtpsmyoutvhc.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5xa2xvd3R5eHRwc215b3V0dmhjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc1NTQyMjUsImV4cCI6MjA1MzEzMDIyNX0.5iQK44rsbX7rq2Ctf8lk9vLPwb-NB73T4QtvkBO27t8', // Replace with your Supabase anon key
  );

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
