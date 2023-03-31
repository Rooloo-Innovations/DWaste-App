import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardMaterial extends StatelessWidget {
  const RewardMaterial({
    super.key,
    required this.productType,
    required this.scannedOn,
    required this.pointsEarned,
  });

  final productType;
  final scannedOn;
  final pointsEarned;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: Image.asset(
                  'assets/images/plastic_bottle_1.png',
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$productType",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                  Text(
                    "$scannedOn",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "+",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green),
              ),
              const SizedBox(
                width: 2,
              ),
              SvgPicture.asset(
                'assets/images/icons/DIcon.svg',
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "$pointsEarned",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.green),
              ),
            ],
          )
        ],
      ),
    );
  }
}
