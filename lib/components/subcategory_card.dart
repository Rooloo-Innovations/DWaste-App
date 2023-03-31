import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';

class SubCategoryCard extends StatelessWidget {
  const SubCategoryCard({
    Key? key,
    required this.id,
    required this.title,
    required this.iconURL,
  }) : super(key: key);

  final String id;
  final String title;
  final String iconURL;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     // builder: (context) => const RewardScreen(),
          //     ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
              padding: const EdgeInsets.all(12),
              color: AppColors.backgroundGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: 64,
                      height: 64,
                      child: Image.network(iconURL, fit: BoxFit.contain)),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Text(title,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
