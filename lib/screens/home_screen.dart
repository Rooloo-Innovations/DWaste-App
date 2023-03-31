import 'package:dwaste/components/bottom_navbar.dart';
import 'package:dwaste/models/app_colors.dart';
import 'package:dwaste/screens/categories_screen.dart';
import 'package:dwaste/screens/dashboard.dart';
import 'package:dwaste/screens/profile_screen.dart';
// import 'package:dwaste/screens/reward_received_screen.dart';
import 'package:dwaste/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
    this.screenIndex = 0,
  }) : super(key: key);
  final int screenIndex;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex=widget.screenIndex;
  }
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

  static final List<Widget> _widgetOptions = <Widget>[
    const Dashboard(),
    ScanScreen(),
    // const RewardsPage(),
    const CategoriesScreen(),
    // ProductListScreen(),
    const ProfileScreen(),
  ];
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
      bottomNavigationBar:
          BottomNavbar(selectedIndex: _selectedIndex, onTapped: _onItemTapped),
    );
  }
}
