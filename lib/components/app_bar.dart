import 'package:flutter/material.dart';

import '../models/app_colors.dart';

AppBar buildAppBar() {
  return AppBar(
    iconTheme: const IconThemeData(
      color: AppColors.green,
    ),
    centerTitle: true,
    title: Image.asset('assets/images/logo_horizontal.png'),
  );
}
