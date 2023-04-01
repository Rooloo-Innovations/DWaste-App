import 'package:dwaste/components/category_card.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/gql_client.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCategories();
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
        print(categoryList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                children: List<Widget>.generate(
                  categoryList.length,
                  (index) => CategoryCard(
                      subcategories: categoryList[index]['subcategories'],
                      title: categoryList[index]['name'],
                      iconURL: categoryList[index]['iconURL']),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
