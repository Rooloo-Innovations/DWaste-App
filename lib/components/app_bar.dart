import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/app_colors.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.green, size: 28),
      onPressed: () => Navigator.of(context).pop(),
    ),
    automaticallyImplyLeading: false,
    centerTitle: true,
    toolbarHeight: 72,
    title: SvgPicture.asset(
      'assets/images/icons/DwasteAppBarLogo.svg',
      width: 42,
      height: 42,
      colorFilter: const ColorFilter.mode(AppColors.green, BlendMode.srcIn),
    ),
    backgroundColor: AppColors.white,
    elevation: 0, // 1
  );
}
