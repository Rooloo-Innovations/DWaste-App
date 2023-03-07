import 'package:flutter/material.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String logoAsset;
  final VoidCallback onHomeButtonPressed;
  final bool showBackButton;

  const DAppBar({
    Key? key,
    required this.title,
    required this.logoAsset,
    required this.onHomeButtonPressed,
    this.showBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
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
          : IconButton(
        icon: Image.asset(
          logoAsset,
          height: 32,
          width: 32,
        ),
        onPressed: () {},
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: onHomeButtonPressed,
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}


