import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionMaterial extends StatelessWidget {
  const TransactionMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12),
                child: SizedBox(
                  height: 58,
                  width: 58,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundColor,
                      ),
                      child: Image.asset(
                        "assets/images/headphones .png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Plastic",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black),
                  ),
                  Text(
                    "Today, at 11:48 PM",
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
                "-",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.red),
              ),
              const SizedBox(
                width: 8,
              ),
              SvgPicture.asset(
                'assets/images/icons/DIcon.svg',
                width: 20,
                height: 20,
                colorFilter:
                    const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
              ),
              const SizedBox(
                width: 8,
              ),
              const Text(
                "23.25",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}
