import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/view/screen/home_screen.dart';
import 'package:foodrecipeapp/view/widget/Custom_product_Item_widget.dart';

class ScanUotputScreen extends StatefulWidget {
  ScanUotputScreen({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  State<ScanUotputScreen> createState() => _ScanUotputScreenState();
}

class _ScanUotputScreenState extends State<ScanUotputScreen> {
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    //Method for listening controller
    _controller.addListener(() {
      setState(() {});
    });
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverAppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: mainText,
                    size: 20,
                  )),
              pinned: true,
              titleSpacing: 0,
              elevation: 0,
              toolbarHeight: 80,
              // Here we have created a conditional statement to chang the appearance of the appBar

              title: _controller.hasClients && _controller.offset > 250.0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 28,
                          backgroundImage:
                              AssetImage("assets/images/Food Picture.png"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.displayLarge,
                        )
                      ],
                    )
                  : SizedBox(),
              backgroundColor: Colors.white,
              expandedHeight: 350,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(25.0),
                      child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage("assets/images/Food Picture.png")),
                    ),
                    Text(
                      "Pancakes",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                height: 8,
                color: form,
              ),
            ),
            SliverGrid.count(
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.5,
              children: List.generate(6, (index) => CustomProductItemWidget()),
            )
          ],
        ),
      ),
    ));
  }
}
