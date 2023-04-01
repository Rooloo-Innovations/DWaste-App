import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/subcategory_screen.dart';
import 'package:flutter/material.dart';

class ShopScreenCategoryBox extends StatelessWidget {
  const ShopScreenCategoryBox({
    super.key,
    required this.title,
    required this.iconURL,
    required this.subcategories,
  });
  final List subcategories;
  final String title;
  final String iconURL;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubCategoryScreen(subcategories: subcategories),
        ));
      },
      child: Container(
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                decoration: const BoxDecoration(color: AppColors.white),
                padding: const EdgeInsets.all(8),
                child: SizedBox(
                  width: 52,
                  height: 52,
                  child: Image.network(iconURL),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
