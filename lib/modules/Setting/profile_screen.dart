import 'package:bella_app/modules/Setting/add_payment_method_screen.dart';
import 'package:bella_app/shared/local/languages/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../shared/app_string.dart';
import 'myorder_screen.dart';
import 'reviews_screen.dart';
import 'setting_screen.dart';
import 'widgets/profile_info.dart';
import 'widgets/profile_menu_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(Icons.search, color: theme.iconTheme.color),
        //   onPressed: () {},
        // ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined, color: theme.iconTheme.color),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
        elevation: 0,
        backgroundColor: theme.cardColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth * 0.05;
          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileInfo(
                  name: 'Bruno Pham',
                  email: 'bruno203@gmail.com',
                  imageUrl: AppString.profile,
                ),
                const SizedBox(height: 20),
                ProfileMenuOption(
                  title: AppString.myOrders(context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyOrderScreen(),
                      ),
                    );
                  },
                ),
                ProfileMenuOption(
                  title: 'Shipping Addresses'.tr(context),
                  onTap: () {},
                ),
                ProfileMenuOption(
                  title: 'Payment Method'.tr(context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddPaymentMethodScreen(),
                      ),
                    );
                  },
                ),
                ProfileMenuOption(
                  title: 'My reviews'.tr(context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyReviewsScreen(),
                      ),
                    );
                  },
                ),
                ProfileMenuOption(
                  title: AppString.setting(context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Logout", style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Add your logout logic here, e.g., navigate to login screen
              },
            ),
          ],
        );
      },
    );
  }
}
