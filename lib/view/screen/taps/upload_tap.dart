import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';
import 'package:foodrecipeapp/models/product.dart';
import 'package:foodrecipeapp/view/widget/CustomSlider.dart';
import 'package:foodrecipeapp/view/widget/custom_button.dart';
import 'package:foodrecipeapp/view/widget/custom_text_fild_in_upload.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

class UploadTap extends StatefulWidget {
  const UploadTap({Key? key}) : super(key: key);

  @override
  State<UploadTap> createState() => _UploadTapState();
}

class _UploadTapState extends State<UploadTap> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;
  File? _image;
  String? _imageUrl;
  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    _foodNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/image 8.png",
                height: 100,
              ),
              const SizedBox(height: 10),
              const Text("Successfully Uploaded"),
            ],
          ),
          actions: [
            Center(
              child: SizedBox(
                width: 150,
                child: CustomButton(
                  text: "Back to Home",
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(
                        context); // Pop the dialog, then the upload screen
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String?> _uploadImageToStorage(File imageFile) async {
    try {
      final imageExt = path.extension(imageFile.path);
      final imageName =
          'recipe_image_${DateTime.now().millisecondsSinceEpoch}$imageExt';

      await supabase.storage
          .from("recipes-images")
          .upload(imageName, imageFile);

      // Use the public URL instead of signed URL
      final publicUrl =
          supabase.storage.from("recipes-images").getPublicUrl(imageName);

      return publicUrl;
    } catch (e) {
      print('Error uploading image to Supabase Storage: $e');
      return null;
    }
  }

  void _uploadRecipe(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final user = supabase.auth.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("User not logged in. Please log in.")));
          return;
        }

        String? imageUrl;
        if (_image != null) {
          imageUrl = await _uploadImageToStorage(_image!);
          if (imageUrl == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to upload image.")));
            return;
          }
        }

        final recipe = Product(
          userName: user.email ?? "Anonymous",
          profileImage: "assets/images/Avatar.png",
          productImage: imageUrl ?? "",
          productName: _foodNameController.text,
          productTypeIcon: 'timer_outlined',
          productTime: "30 min",
          productCategory: "Food",
          userId: user.id,
          description: _descriptionController.text,
        );

        await supabase.from("recipes").insert(recipe.toJson());

        setState(() {
          _isLoading = false;
        });

        _showSuccessDialog(context);
      } catch (e) {
        print("Error uploading recipe: $e");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error uploading recipe. Please try again.")));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(color: Secondary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addCoverPhoto(),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Food Name",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFildInUpload(
                        hint: "Enter food name",
                        radius: 30,
                        controller: _foodNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter the Food Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextFildInUpload(
                        hint: "Tell a little about your food",
                        maxLines: 4,
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter the Description";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const CustomSlider(),
                      const SizedBox(
                        height: 7,
                      ),
                      Center(
                        child: SizedBox(
                            width: 150,
                            child: CustomButton(
                              text: "Upload",
                              onTap: () => _uploadRecipe(context),
                              isLoading: _isLoading,
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addCoverPhoto() {
    return InkWell(
      onTap: () async {
        final ImagePicker _picker = ImagePicker();
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          File selectedImage = File(image.path);
          setState(() {
            _image = selectedImage;
          });
        }
      },
      child: DottedBorder(
          dashPattern: const [15, 5],
          color: outline,
          strokeWidth: 2,
          borderType: BorderType.RRect,
          radius: const Radius.circular(10),
          child: SizedBox(
            width: double.infinity,
            height: 160,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.photo,
                          size: 65,
                          color: Colors.grey,
                        ),
                        Text(
                          "Add Cover Photo",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text("Up to 12mp ")
                      ],
                    )
                  : Image.file(
                      _image!,
                      fit: BoxFit.cover,
                    ),
            ),
          )),
    );
  }
}
