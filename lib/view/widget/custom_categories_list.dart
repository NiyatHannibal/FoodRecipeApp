import 'package:flutter/material.dart';
import 'package:foodrecipeapp/constants/colors.dart';

class CustomCategoriesList extends StatefulWidget {
  const CustomCategoriesList({Key? key, required this.onCategorySelected})
      : super(key: key);
  final Function(String) onCategorySelected;

  @override
  State<CustomCategoriesList> createState() => _CustomCategoriesListState();
}

class _CustomCategoriesListState extends State<CustomCategoriesList> {
  int _selectedIndex = 0;
  List<String> categories = [
    "All",
    "Food",
    "Drink",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Categories",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return menuButton(
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onCategorySelected(categories[index]);
                },
                isSelected: _selectedIndex == index,
                text: categories[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget menuButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 85,
          height: 45,
          decoration: BoxDecoration(
            color: isSelected ? primary : form,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: isSelected ? Colors.white : SecondaryText,
                ),
          ),
        ),
      ),
    );
  }
}
