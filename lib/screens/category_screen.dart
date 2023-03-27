import 'package:dwaste/widgets/CategoryList.dart';
import 'package:dwaste/widgets/DAppbar.dart';
import 'package:dwaste/widgets/DBottomNavBar.dart';
import 'package:dwaste/widgets/DSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/QueryService.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String categories = """
  query OnlyCategories {
  onlyCategories {
    success
    message
    categories {
      id
      name
      iconURL
    }
  }
}""";
  final queryservice = QueryService();

  get categoryresults async => await queryservice.executeQuery(categories, "categories");

  @override
  void initState() async {
    super.initState();
    await queryservice.executeQuery(categories, "categories");
    final categoryresults = queryservice.getQueryResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppbar(),
      body: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Column(
            children: [
              const Text("Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              DSearchBar(items: productresults),
              const SizedBox(height: 24),
              const Text("Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              CategoryList(categories: categoryresults),
            ],
          )),
      bottomNavigationBar: const DBottomNavBar(),
    );
  }
}
