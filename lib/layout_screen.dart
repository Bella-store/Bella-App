import 'package:bella_app/shared/local/languages/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'modules/Cart/cart_screen.dart';
import 'modules/Favorites/favorites_screen.dart';
import 'modules/Home/home_screen.dart';
import 'modules/Setting/profile_screen.dart';
import 'shared/app_color.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  LayoutScreenState createState() => LayoutScreenState();
}

class LayoutScreenState extends State<LayoutScreen> {
  late PersistentTabController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);

    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set your desired color here
      statusBarIconBrightness:
          Brightness.dark, // Set the icons color (dark/light)
    ));
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      FavoritesScreen(),
      CartScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home".tr(context),
        activeColorPrimary: AppColor.blackColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: "Favorites".tr(context),
        activeColorPrimary: AppColor.blackColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: "Cart".tr(context),
        activeColorPrimary: AppColor.blackColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile".tr(context),
        activeColorPrimary: AppColor.blackColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildScreens()[_selectedIndex],
        bottomNavigationBar: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          onItemSelected: _onItemTapped,
          confineToSafeArea: true,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(10.0),
            colorBehindNavBar: Colors.white,
          ),
          navBarStyle: NavBarStyle.style7,
        ),
      ),
    );
  }
}
