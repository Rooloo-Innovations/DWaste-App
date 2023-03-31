import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/dashboard.dart';
import 'package:dwaste/screens/product_list_screen.dart';
import 'package:dwaste/screens/profile_screen.dart';
// import 'package:dwaste/screens/reward_received_screen.dart';
import 'package:dwaste/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    ScanScreen(),
    // const RewardsPage(),
    // CategoriesScreen(),
    ProductListScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ColorFilter returnIconColor(int index) {
    if (_selectedIndex == index) {
      return const ColorFilter.mode(AppColors.green, BlendMode.srcIn);
    } else {
      return const ColorFilter.mode(AppColors.grey, BlendMode.srcIn);
    }
  }

  ColorFilter returnLogoColor() {
    if (_selectedIndex == 3 || _selectedIndex == 2) {
      return const ColorFilter.mode(AppColors.green, BlendMode.srcIn);
    } else {
      return const ColorFilter.mode(AppColors.white, BlendMode.srcIn);
    }
  }

  Color returnAppBarBGColor() {
    if (_selectedIndex == 3 || _selectedIndex == 2) {
      return AppColors.white;
    } else {
      return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: AppColors.green, size: 28),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        automaticallyImplyLeading: false,
        leading: null,
        centerTitle: true,
        toolbarHeight: 72,
        title: SvgPicture.asset(
          'assets/images/icons/DwasteAppBarLogo.svg',
          width: 42,
          height: 42,
          colorFilter: returnLogoColor(),
        ),
        backgroundColor: returnAppBarBGColor(),
        elevation: 0, // 1
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.white,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 38,
              child: SvgPicture.asset(
                'assets/images/icons/HomeIcon.svg',
                width: 28,
                height: 28,
                colorFilter: returnIconColor(0),
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 38,
              child: SvgPicture.asset(
                'assets/images/icons/ScanIcon.svg',
                width: 28,
                height: 28,
                colorFilter: returnIconColor(1),
              ),
            ),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 38,
              child: SvgPicture.asset(
                'assets/images/icons/CartIcon.svg',
                width: 28,
                height: 28,
                colorFilter: returnIconColor(2),
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 38,
              child: SvgPicture.asset('assets/images/icons/DIcon.svg',
                  width: 28, height: 28, colorFilter: returnIconColor(3)),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
