import 'package:dwaste/widgets/CategoryList.dart';
import 'package:dwaste/widgets/DAppbar.dart';
import 'package:dwaste/widgets/DBottomNavBar.dart';
import 'package:dwaste/widgets/DSearchBar.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget { //incomplete
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
              DSearchBar(items: items),
              const SizedBox(height: 24),

            ],
          )),
      bottomNavigationBar: const DBottomNavBar(),
    );
  }
}
