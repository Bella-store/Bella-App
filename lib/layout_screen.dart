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

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.whiteColor,
      statusBarIconBrightness: Brightness.dark,
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
        activeColorPrimary: AppColor.mainColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: "Favorites".tr(context),
        activeColorPrimary: AppColor.mainColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: "Cart".tr(context),
        activeColorPrimary: AppColor.mainColor,
        inactiveColorPrimary: AppColor.greyColor,
        activeColorSecondary: AppColor.whiteColor,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: "Profile".tr(context),
        activeColorPrimary: AppColor.mainColor,
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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
            colorBehindNavBar:
                isDarkMode ? AppColor.darkBackgroundColor : AppColor.whiteColor,
          ),
          backgroundColor:
              isDarkMode ? AppColor.darkCardColor : AppColor.whiteColor,
          navBarStyle: NavBarStyle.style7,
        ),
      ),
    );
  }
}
