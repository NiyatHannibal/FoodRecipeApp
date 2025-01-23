import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/models/product.dart';

class ProductItemScreen extends StatelessWidget {
  const ProductItemScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network(
                // Modified line
                "https://nqklowtyxtpsmyoutvhc.supabase.co/storage/v1/object/public/recipes-images/recipe_image_1737619810452.png",
                fit: BoxFit.cover,
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
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  print('Error loading image: $exception');
                  return const Icon(Icons.error);
                },
              ),
            ),
            buttonArrow(context),
            scroll(context, product),
          ],
        ),
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  scroll(BuildContext context, Product product) {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    product.productName,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Icon(
                        product.productTypeIcon == 'timer_outlined'
                            ? Icons.timer_outlined
                            : Icons.error,
                        size: 14.0,
                        color: SecondaryText,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        product.productTime,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: SecondaryText),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            product.profileImage.startsWith('assets')
                                ? AssetImage(product.profileImage)
                                : NetworkImage(product.profileImage)
                                    as ImageProvider, // Modified line
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        product.userName,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: mainText),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.description ??
                        'Your recipe has been uploaded, you can see it on your profile. Your recipe has been uploaded, you can see it on your',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: SecondaryText),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
