import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';


class CategoryList extends StatelessWidget {
  final List<Category> categories;

  CategoryList({required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 114),
      color: AppColors.lightgreen,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              // Navigate to category page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => categories[index].page,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundColor: categories[index].color,
                    child: Icon(
                      categories[index].icon,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    categories[index].name,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Category {
  final IconData icon;
  final String name;
  final Color color;
  final Widget page;

  Category({required this.icon, required this.name, required this.color, required this.page});
}