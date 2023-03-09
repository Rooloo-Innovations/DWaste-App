import 'package:flutter/material.dart';

class DAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const DAppbar({
    Key? key,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: IconButton(
            icon: Image.asset(
              'assets/images/logo.png',
              height: 32,
              width: 32,
            ),
            onPressed: () => Navigator.pushNamed(context, '/')),
        leading: showBackButton
            ? IconButton(
          icon: Image.asset(
            'assets/back.png',
            height: 24,
            width: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
            : null);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}
