import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/product_card.dart';
import '../models/gql_client.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List productsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProductsbyCategoryId();
  }

  void fetchProductsbyCategoryId() async {
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
    '''), variables: {"subCategoryId": "640c29be27c311751b05ee70"});

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        productsList = result.data!['allProductsByCategory']['products'];
        print(productsList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ),
                ),

                // children: <Widget>[
                //   ProductCard(
                //     name: 'Headphones',
                //     price: 10,
                //     image: 'assets/images/headphone.png',
                //   ),
                //   ProductCard(
                //     name: 'Headphone',
                //     price: 10,
                //     image: 'assets/images/headphone.png',
                //   ),
                //   ProductCard(
                //     name: 'Headphone',
                //     price: 10,
                //     image: 'assets/images/headphone.png',
                //   ),
                //   ProductCard(
                //     name: 'Headphone',
                //     price: 10,
                //     image: 'assets/images/headphone.png',
                //   ),
                //   ProductCard(
                //     name: 'Headphone',
                //     price: 10,
                //     image: 'assets/images/headphone.png',
                //   ),
                //   ProductCard(
                //     name: 'Headphone',
                //     price: 10,
                //     image: 'assets/images/headphone.png',
                //   ),
                // ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
