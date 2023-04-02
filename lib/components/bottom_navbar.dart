import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({
    Key? key,
    required this.selectedIndex,
    required this.onTapped,
  }) : super(key: key);
  final int selectedIndex;
  final Function(int) onTapped;
  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
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

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      onTap: (index) {
        widget.onTapped(index);
        _onItemTapped(index);
      },
    );
  }
}
