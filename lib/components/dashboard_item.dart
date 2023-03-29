import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 12),
        ],
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 140,
              width: 140,
              child: Image.asset(
                "assets/images/cardboard_box.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Cardboard",
            style: TextStyle(
              color: AppColors.green,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "50 DENR",
            style: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
