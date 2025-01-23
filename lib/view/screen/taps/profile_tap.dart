import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/models/product.dart';
import 'package:foodrecipeapp/view/widget/Custom_product_Item_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileTap extends StatefulWidget {
  ProfileTap({Key? key, this.product}) : super(key: key);

  final Product? product;

  @override
  State<ProfileTap> createState() => _ProfileTapState();
}

class _ProfileTapState extends State<ProfileTap> {
  List<Product> _products = [];
  bool _isLoading = true;
  String userName = " ";
  final supabase = Supabase.instance.client;

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = supabase.auth.currentUser;

      if (user != null) {
        // Fetch user details first to have user data
        final userDetailsResponse =
            await supabase.from('users').select().eq('id', user.id);

        if (userDetailsResponse.isNotEmpty) {
          final Map<String, dynamic>? userDetails =
              userDetailsResponse.single; // You can now use `single()` safely
          if (userDetails != null) {
            setState(() {
              userName = userDetails['name'] ?? "User";
            });
          }
        } else {
          print("No user data found for id: ${user.id}");
          setState(() {
            userName = "User";
          });
        }

        // Fetch recipes
        final List<dynamic> recipesData =
            await supabase.from('recipes').select('*').eq('userId', user.id);

        _products =
            recipesData.map((recipe) => Product.fromSupabase(recipe)).toList();
      }
    } catch (e) {
      print("Error in fetching data: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      'assets/images/Avatar - Copy.png')),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              userName,
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // Center the Column
                            children: [
                              Column(
                                children: [
                                  Text(
                                    _products.length.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Recipes",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: SecondaryText),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 1 / 1.3,
                          children: List.generate(
                              _products.length,
                              (index) => CustomProductItemWidget(
                                    showUser: false,
                                    product: _products[index],
                                  )),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
