import 'package:dwaste/components/app_bar.dart';
import 'package:dwaste/components/app_textfield.dart';
import 'package:dwaste/components/bottom_navbar.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _withdrawAmountController =
      TextEditingController();
  final TextEditingController _publicKeyController = TextEditingController();
  int _selectedIndex = 3;
  void _onItemTapped(int index) {
    // setState(() {
    //   _selectedIndex = index;
    // });
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => HomeScreen(screenIndex: index),
    ));
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext ctx) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.spaceAround,
          contentPadding: const EdgeInsets.all(16.0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0))),
          backgroundColor: AppColors.white,
          content: SingleChildScrollView(
            child: Text('Are you sure you want to withdraw your DENR tokens'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.red),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Withdraw',
                style: TextStyle(color: AppColors.green),
              ),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar:
          BottomNavbar(selectedIndex: _selectedIndex, onTapped: _onItemTapped),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        children: [
          SizedBox(
            height: 160,
            child: Image.asset(
              "assets/images/balance_earth.png",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Thank you for recycling and helping our planet! You can now withdraw your DENR tokens as a reward.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.green,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Together, we can make a difference.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.green,
              fontSize: 16,
            ),
          ),
          const SizedBox(
            height: 64,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Your balance:", textAlign: TextAlign.end),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/DIcon.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                        AppColors.green, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text(
                    "54",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.green),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          AppTextFields(
            controller: _withdrawAmountController,
            keyboardType: TextInputType.text,
            text: 'Withdraw Amount',
            hintText: 'Enter amount you want to withdraw',
            onChanged: (value) {},
          ),
          AppTextFields(
            controller: _publicKeyController,
            keyboardType: TextInputType.text,
            text: 'Public Key',
            hintText: 'Enter your public key',
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 8,
          ),
          TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
              ),
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
              backgroundColor: MaterialStateProperty.all(AppColors.green),
            ),
            onPressed: () {
              _showDialog();
            },
            child: const Text(
              'Withdraw',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
