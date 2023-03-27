import 'package:dwaste/widgets/CategoryList.dart';
import 'package:dwaste/widgets/DAppbar.dart';
import 'package:dwaste/widgets/DBottomNavBar.dart';
import 'package:dwaste/widgets/DSearchBar.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/QueryService.dart';

class ShopScreen extends StatefulWidget {
  //incomplete
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String products = """
  query AllProducts {
  allProducts {
    success
    message
    products {
      id
      name
      description
      stock
      pinCode
      category {
        id
        name
      }
      subCategory {
        id
        name
      }
      actualPrice
      discountedPrice
      imageName
      imageURL
    }
  }
}
""";
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

  get productresults => null;

  get categoryresults => null;

  @override
  void initState() async {
    super.initState();
    await queryservice.executeQuery(products, "products");
    final productresults = queryservice.getQueryResults();
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
              const Text("Hello {name}!",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              RichText(
                  text: const TextSpan(
                text: 'Welcome To',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Shop',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              )),
              const SizedBox(height: 24),
              const Text("Categories",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              DSearchBar(items: productresults),
              const SizedBox(height: 24),
              CategoryList(categories: categoryresults),
            ],
          )),
      bottomNavigationBar: const DBottomNavBar(),
    );
  }
}
