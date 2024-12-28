import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/scan_output_screen.dart';
import 'package:foodrecipeapp/view/screen/taps/home_tap.dart';
import 'package:foodrecipeapp/view/screen/taps/notifcation_tap.dart';
import 'package:foodrecipeapp/view/screen/taps/profile_tap.dart';
import 'package:foodrecipeapp/view/screen/taps/scan_tap.dart';
import 'package:foodrecipeapp/view/screen/taps/upload_tap.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
// we ut the bottom navigation bar in a separate method
      bottomNavigationBar: bottomNavigationBar(),
      // we put the FloatingAction Bottom in a separate method
      floatingActionButton: floatingActionButton(),
      // here is the location of the floating action button
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      body: taps[_currentIndex],
    ));
  }

// list of taps
  List<Widget> taps = [
    const HomeTap(),
    const UploadTap(),
    const ScanTap(),
    NotitcationTap(),
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
          setState(() {});
        } else if (index == 3) {
          setState(() {
            _currentIndex = index;
          });
        } else if (index == 4) {
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

  // list of items
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
      icon: Icon(
        IconlyBold.scan,
        color: Colors.white,
      ),
      label: "Scan",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBold.notification),
      label: "Notification",
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyBold.profile),
      label: "Profile",
    ),
  ];

  floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          showModalBottomSheet(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25))),
              context: context,
              builder: (context) => _bottomSheet(context));
        });
      },
      backgroundColor: primary,
      elevation: 0,
      child: const Icon(
        IconlyBold.scan,
      ),
    );
  }

  _bottomSheet(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: 70,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close)),
            title: Text(
              "Choose one option",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: mainText),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScanUotputScreen(
                                title: "Food",
                              )));
                },
                child: Container(
                  height: 170,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: outline),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/image 6.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Food",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: mainText),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScanUotputScreen(title: "Ingredient")));
                },
                child: Container(
                  height: 170,
                  width: 155,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: outline),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset(
                        "assets/images/image 7.png",
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ingredient",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: mainText),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
