import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/subcategory_screen.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.id,
    required this.title,
    required this.iconURL,
  });
  final String id;
  final String title;
  final String iconURL;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SubCategoryScreen(),
        ));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
            padding: const EdgeInsets.all(12),
            color: AppColors.backgroundGreen,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(title,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500)),
                ),
                const SizedBox(
                  height: 18,
                ),
                Center(
                  child: Expanded(
                    child: Image.network(iconURL, fit: BoxFit.contain),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
