import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../components/bottom_navbar.dart';
import '../models/gql_client.dart';
import 'home_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  final product;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List product = [];
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
    fetchProductById(widget.product);
  }

  void fetchProductById(productId) async {
    final GraphQLClient client = await getClient();

    final QueryOptions options = QueryOptions(document: gql(r'''
query AllProductsByProductID($productId: String!) {
  allProductsByProductID(productID: $productId) {
    success
    message
    products {
      id
      name
      description
      stock
      pinCode
      actualPrice
      discountedPrice
      imageName
      imageURL
    }
  }
}
    '''), variables: {
      "productId": productId,
    });

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception.toString();
    } else {
      setState(() {
        product = result.data!['allProductsByProductID']['products'];
      });
    }
  }

  final _headerStyle = const TextStyle(
      color: AppColors.black, fontSize: 15, fontWeight: FontWeight.w600);
  final _contentStyle = const TextStyle(
      color: AppColors.black, fontSize: 14, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: AppColors.white,
      bottomNavigationBar:
          BottomNavbar(selectedIndex: _selectedIndex, onTapped: _onItemTapped),
      body: product.isEmpty
          ? const Center(
              child: SpinKitFadingCube(
                color: AppColors.green,
                size: 50.0,
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              children: [
                SizedBox(
                  height: 350,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      product[0]['imageURL'],
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Image(
                            image: AssetImage('assets/images/placeholder.png'));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  product[0]['name'],
                  style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/icons/DIcon.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                          AppColors.green, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      product[0]['discountedPrice'].toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.green),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      'assets/images/icons/DIcon.svg',
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                          Color(0xffc2c2c2), BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      product[0]['actualPrice'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffc2c2c2),
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  height: 2.0,
                  color: AppColors.grey,
                ),
                Accordion(
                  disableScrolling: true,
                  contentBorderRadius: 0,
                  headerBorderRadius: 0,
                  rightIcon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.black,
                    size: 20,
                  ),
                  flipRightIconIfOpen: true,
                  maxOpenSections: 1,
                  headerPadding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                  sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                  sectionClosingHapticFeedback: SectionHapticFeedback.light,
                  children: [
                    AccordionSection(
                      isOpen: true,
                      headerBackgroundColor: Colors.white,
                      headerBackgroundColorOpened: Colors.white,
                      contentBorderWidth: 0,
                      header: Text('product details', style: _headerStyle),
                      content:
                          Text(product[0]['description'], style: _contentStyle),
                      contentHorizontalPadding: 0,
                      // onOpenSection: () => print('onOpenSection ...'),
                      // onCloseSection: () => print('onCloseSection ...'),
                    ),
                  ],
                ),
                AppTextButton(
                  text: 'Buy Now',
                  onPressed: () => {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderScreen(
                        productId: product[0]['id'],
                        productName: product[0]['name'],
                        productPrice: product[0]['discountedPrice'],
                        productImage: product[0]['imageURL'],
                      ),
                    ))
                  },
                ),
                const SizedBox(
                  height: 46,
                )
              ],
            ),
    );
  }
}

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
        backgroundColor: MaterialStateProperty.all(AppColors.green),
      ),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.white),
      ),
    );
  }
}
