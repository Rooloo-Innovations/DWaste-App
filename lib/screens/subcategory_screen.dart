import 'package:dwaste/components/bottom_navbar.dart';
import 'package:dwaste/components/subcategory_card.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../components/app_bar.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({Key? key, required this.subcategories})
      : super(key: key);

  final List subcategories;

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
                children: List<Widget>.generate(
                  widget.subcategories.length,
                  (index) => SubCategoryCard(
                    id: widget.subcategories[index]['id'],
                    title: widget.subcategories[index]['name'],
                    iconURL: widget.subcategories[index]['iconURL'],
                  ),
                ),
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
