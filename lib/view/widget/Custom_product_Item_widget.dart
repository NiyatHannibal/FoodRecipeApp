import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/models/product.dart';
import 'package:foodrecipeapp/view/screen/product_item_screen.dart';
import 'package:foodrecipeapp/view/screen/taps/profile_tap.dart';

class CustomProductItemWidget extends StatelessWidget {
  CustomProductItemWidget(
      {Key? key, required this.product, this.showUser = true})
      : super(key: key);
  final bool showUser;
  final Product product;

  Widget buildRecipeImage(String imageUrl) {
    print('Image URL (inside buildRecipeImage): $imageUrl');
    return Image.network(
      imageUrl,
      fit: BoxFit.cover, // Or any other appropriate fit you want
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          Text("Failed to load image"),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('Product Image URL (inside build): ${product.productImage}');

    return Container(
      width: 165,
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and profile picture (with navigation to profile)
          if (showUser)
            InkWell(
              // Wrap the profile part with InkWell
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileTap(
                      product: product, // Send product data
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        product.profileImage,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      product.userName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: mainText),
                    ),
                  ],
                ),
              ),
            ),
          // Product image
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                alignment: Alignment.centerLeft,
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductItemScreen(
                          product: product,
                        ),
                      ),
                    );
                  },
                  child: product.productImage.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: buildRecipeImage(
                              "https://nqklowtyxtpsmyoutvhc.supabase.co/storage/v1/object/public/recipes-images/recipe_image_1737619810452.png"))
                      : const Center(child: Icon(Icons.image_not_supported)),
                  // END: REPLACED CHILD PROPERTY
                )),
          ),
          // Product name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              product.productName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(children: [
                // START: Updated Icon Widget
                Icon(
                    product.productTypeIcon == 'timer_outlined'
                        ? Icons.timer_outlined
                        : Icons.error,
                    size: 14.0,
                    color: SecondaryText),
                // END: Updated Icon Widget
                const SizedBox(
                  width: 5,
                ),
                Text(
                  product.productTime,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: SecondaryText),
                ),
              ])),
        ],
      ),
    );
  }
}
