import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/bottom_navbar.dart';
import '../components/product_card.dart';
import '../models/gql_client.dart';
import 'home_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key, required this.subCategoryId})
      : super(key: key);

  final String subCategoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List productsList = [];

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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductsByCategoryId(widget.subCategoryId);
  }

  void fetchProductsByCategoryId(subCategoryId) async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(document: gql(r'''
query AllProductsByCategory($subCategoryId: String!) {
  allProductsByCategory(subCategoryID: $subCategoryId) {
    success
    message
    products {
      id
      name
      actualPrice
      discountedPrice
      imageURL
    }
  }
}
    '''), variables: {"subCategoryId": subCategoryId});

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        productsList = result.data!['allProductsByCategory']['products'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar:
          BottomNavbar(selectedIndex: _selectedIndex, onTapped: _onItemTapped),
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: GridView.count(
                primary: false,
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                children: List<Widget>.generate(
                  productsList.length,
                  (index) => ProductCard(
                    name: productsList[index]['name'],
                    price: productsList[index]['discountedPrice'],
                    image: productsList[index]['imageURL'],
                    product: productsList[index]['id'],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
