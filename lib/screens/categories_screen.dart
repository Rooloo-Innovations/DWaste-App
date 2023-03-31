import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/components/bottom_navbar.dart';
import 'package:dwaste/components/category_card.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
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
              child: GridView.count(
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                childAspectRatio: 4 / 5,
                children: const <Widget>[
                  CategoryCard(
                    title: "Electronics",
                    iconURL:
                        "https://dwaste.knowjamil.com/uploads/icons?image=electronics.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  CategoryCard(
                    title: "Sports & Fitness",
                    iconURL:
                        "https://dwaste.knowjamil.com/uploads/icons?image=clothes.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  CategoryCard(
                    title: "Books",
                    iconURL:
                        "https://dwaste.knowjamil.com/uploads/icons?image=books.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  CategoryCard(
                    title: "Sports & Fitness",
                    iconURL:
                        "https://dwaste.knowjamil.com/uploads/icons?image=clothes.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  CategoryCard(
                    title: "Books",
                    iconURL:
                        "https://dwaste.knowjamil.com/uploads/icons?image=books.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  CategoryCard(
                    title: "Electronics",
                    iconURL:
                        "https://dwaste.knowjamil.com/uploads/icons?image=electronics.png",
                    id: "640c295278809f825d23f26e",
                  ),
                  CategoryCard(
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
