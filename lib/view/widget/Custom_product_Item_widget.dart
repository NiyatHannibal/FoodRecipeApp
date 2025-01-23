import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/models/product.dart';
import 'package:foodrecipeapp/view/screen/product_item_screen.dart';
import 'package:foodrecipeapp/view/screen/taps/profile_tap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomProductItemWidget extends StatefulWidget {
  CustomProductItemWidget(
      {Key? key, required this.product, this.showUser = true})
      : super(key: key);
  final bool showUser;
  final Product product;

  @override
  _CustomProductItemWidgetState createState() =>
      _CustomProductItemWidgetState();
}

class _CustomProductItemWidgetState extends State<CustomProductItemWidget> {
  String? _signedImageUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    print('initState: loadSigned called');
    _loadSignedUrl();
  }

  Future<void> _loadSignedUrl() async {
    setState(() {
      _isLoading = true; // Set loading to true
    });
    print('getsigned started for image: ${widget.product.productImage}');
    if (widget.product.productImage.isNotEmpty) {
      final Uri uri = Uri.parse(widget.product.productImage);
      final String filePath = uri.path;
      final String correctFilePath = filePath.substring(
          filePath.indexOf('/recipes-images/') + '/recipes-images/'.length);

      final imageUrl = await getSignedUrl('recipes-images', correctFilePath);
      print(
          'getSignedUrl returned: $imageUrl for image: ${widget.product.productImage}');
      setState(() {
        _signedImageUrl = imageUrl;
        _isLoading = false; // Set loading to false
      });
    } else {
      setState(() {
        _isLoading = false; // Set loading to false
      });
      print('Image URL is empty for image: ${widget.product.productImage}');
    }
  }

  Future<String?> getSignedUrl(String bucketName, String filePath) async {
    print('getSignedUrl called with bucket: $bucketName, filePath: $filePath');

    final storage = Supabase.instance.client.storage.from(bucketName);

    try {
      final response =
          await storage.createSignedUrl(filePath, 604800); // 1 week expiration
      if (response != null) {
        print('Signed URL generated successfully for filePath: $filePath');
        return response; // Return the signed URL
      }
      return null;
    } catch (e) {
      print('Error generating signed URL for filePath: $filePath, Error: $e');
      return null;
    }
  }

  Widget buildRecipeImage(String imageUrl) {
    print('buildRecipeImage called with URL: $imageUrl');
    return Image.network(
      imageUrl,
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
      errorBuilder: (context, error, stackTrace) {
        print('Error loading image with url: $imageUrl Error: $error');
        return Text("Failed to load image");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
        'build method called for image: ${widget.product.productImage} with _signedImageUrl: $_signedImageUrl');
    return Container(
      width: 165,
      height: 265,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name and profile picture (with navigation to profile)
          if (widget.showUser)
            InkWell(
              // Wrap the profile part with InkWell
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileTap(
                      product: widget.product, // Send product data
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
                        widget.product.profileImage,
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.product.userName,
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
                        product: widget.product,
                        image: _signedImageUrl ?? '',
                      ),
                    ),
                  );
                },
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : (_signedImageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: buildRecipeImage(_signedImageUrl!))
                        : const Center(child: Icon(Icons.image_not_supported))),
              ),
            ),
          ),
          // Product name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.productName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                // START: Updated Icon Widget
                Icon(
                    widget.product.productTypeIcon == 'timer_outlined'
                        ? Icons.timer_outlined
                        : Icons.error,
                    size: 14.0,
                    color: SecondaryText),
                // END: Updated Icon Widget
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.product.productTime,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: SecondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
