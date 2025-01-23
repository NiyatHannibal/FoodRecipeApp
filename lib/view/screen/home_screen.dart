import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/taps/home_tap.dart';
import 'package:foodrecipeapp/view/screen/taps/profile_tap.dart';
import 'package:foodrecipeapp/view/screen/taps/upload_tap.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("Discover Recipes", style: TextStyle(color: Colors.white)),
          backgroundColor: primary,
        ),
        bottomNavigationBar: bottomNavigationBar(),
        body: taps[_currentIndex],
      ),
    );
  }

  List<Widget> taps = [
    HomeTap(),
    const UploadTap(),
    ProfileTap(),
  ];

  bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: primary,
      backgroundColor: Colors.white,
      elevation: 0,
      onTap: (int index) {
        if (index == 0) {
          setState(() {
            _currentIndex = index;
          });
        } else if (index == 1) {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UploadTap()));
          });
        } else if (index == 2) {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      unselectedItemColor: SecondaryText,
      items: items,
      type: BottomNavigationBarType.fixed,
    );
  }

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(IconlyBold.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBold.edit),
      label: "Upload",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBold.profile),
      label: "Profile",
    ),
  ];
}
