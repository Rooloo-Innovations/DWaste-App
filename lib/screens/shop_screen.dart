import 'package:dwaste/components/shop_category_card.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/product_card.dart';
import '../models/gql_client.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List productsList = [];
  List categoryList = [];
  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUser();
    fetchProductsbyCategoryId();
    fetchCategories();
  }

  void fetchUser() async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(document: gql(r'''
query UserDetails {
  userDetails {
    users {
      fullName
    }
  }
}
    '''));

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        name = result.data!['userDetails']['users'][0]['fullName'];
      });
    }
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
    '''), variables: const {"subCategoryId": "640c29be27c311751b05ee70"});

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        productsList = result.data!['allProductsByCategory']['products'];
      });
    }
  }

  void fetchCategories() async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(document: gql(r'''
query AllCategories {
  allCategories {
    success
    message
    categories {
      id
      name
      iconURL
      subcategories {
        id
        name
        iconURL
      }
    }
  }
}
    '''));

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        categoryList = result.data!['allCategories']['categories'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello $name",
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: const [
                      Text("Welcome to",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              fontSize: 26)),
                      SizedBox(
                        width: 8,
                      ),
                      Text("shop",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.green,
                              fontSize: 26)),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 64,
                width: 64,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                    ),
                    child: Image.asset(
                      "assets/images/avatar.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CategoriesScreen(),
                  ));
                },
                child: const Text(
                  "view all >",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.iconGrey),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.backgroundGreen,
              borderRadius: BorderRadius.circular(18),
            ),
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(
                categoryList.length,
                (index) => ShopScreenCategoryBox(
                  subcategories: categoryList[index]['subcategories'],
                  iconURL: categoryList[index]['iconURL'],
                  title: categoryList[index]['name'],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Bestsellers",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 240,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundGreen,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Image.network(
                "https://dwaste.knowjamil.com/uploads?image=macbook_pro.png",
                fit: BoxFit.contain),
          ),
          const SizedBox(
            height: 32,
          ),
          const Text(
            "Recommended",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.black),
          ),
          const SizedBox(
            height: 16,
          ),
          GridView.count(
            padding: EdgeInsets.zero, // set padding to zero
            physics:
                const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            shrinkWrap: true, // You won't see infinite size error
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
        ],
      ),
    );
  }
}
