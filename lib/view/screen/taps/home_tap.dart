import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/models/product.dart';
import 'package:foodrecipeapp/view/widget/custom_categories_list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widget/Custom_product_Item_widget.dart';
import '../../widget/custom_binary_option.dart';

class HomeTap extends StatefulWidget {
  HomeTap({Key? key}) : super(key: key);

  @override
  State<HomeTap> createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];
  List<Product> _allProducts = [];
  bool _isLoading = true;
  final supabase = Supabase.instance.client;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good morning";
    } else if (hour < 17) {
      return "Good afternoon";
    } else {
      return "Good evening";
    }
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final List<dynamic> data = await supabase
            .from('recipes')
            .select('*') // Ensure you specify the columns you want or use '*'
            .eq('userId', user.id);

        // Map the data to your Product model
        _allProducts =
            data.map((recipe) => Product.fromSupabase(recipe)).toList();
      }
      _filterProducts();
    } catch (error) {
      print("Error fetching data: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterProducts() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final nameLower = product.productName.toLowerCase();
        final queryLower = _searchQuery.toLowerCase();
        final categoryLower = product.productCategory.toLowerCase();

        bool nameMatch = _searchQuery.isEmpty || nameLower.contains(queryLower);
        bool categoryMatch = _selectedCategory == 'All' ||
            categoryLower == _selectedCategory.toLowerCase();
        return (nameMatch && categoryMatch);
      }).toList();
    });
  }

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          // the top of screen
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${_getGreeting()}, ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(color: mainText),
                                      ),
                                      Image.asset(
                                        "assets/images/smile.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: TextFormField(
                                      controller: _searchController,
                                      onChanged: (query) {
                                        _searchQuery = query;
                                        _filterProducts();
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Search recipes...",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(color: Colors.black),
                                        fillColor: form,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide.none),
                                        prefixIcon: const Icon(Icons.search,
                                            color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  // Categories List
                                  CustomCategoriesList(
                                    onCategorySelected: (category) {
                                      setState(() {
                                        _selectedCategory = category;
                                        _filterProducts();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // the bottom of the screen
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  AnimatedOpacity(
                                    opacity: 1,
                                    duration: const Duration(milliseconds: 300),
                                    child: CustomBinaryOption(),
                                  ),
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1 / 1.5,
                                    ),
                                    itemCount: _filteredProducts.length,
                                    itemBuilder: (context, index) {
                                      return CustomProductItemWidget(
                                        product: _filteredProducts[index],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )));
  }
}
