import 'package:dwaste/components/bottom_navbar.dart';
import 'package:dwaste/components/subcategory_card.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/app_bar.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key}) : super(key: key);

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(screenIndex: index),
    ));
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: const <Widget>[
                  SubCategoryCard(
                    title: "Electronics",
                    iconURL:
                    "https://dwaste.knowjamil.com/uploads/icons?image=electronics.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  SubCategoryCard(
                    title: "Sports & Fitness",
                    iconURL:
                    "https://dwaste.knowjamil.com/uploads/icons?image=clothes.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  SubCategoryCard(
                    title: "Books",
                    iconURL:
                    "https://dwaste.knowjamil.com/uploads/icons?image=books.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  SubCategoryCard(
                    title: "Sports & Fitness",
                    iconURL:
                    "https://dwaste.knowjamil.com/uploads/icons?image=clothes.png",
                    id: "640c295278809f825d23f26e",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
      BottomNavbar(selectedIndex: _selectedIndex, onTapped: _onItemTapped),
    );
  }
}