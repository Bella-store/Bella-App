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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.black),
            onPressed: () {
              _showLogoutConfirmationDialog(context);
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
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
                  title: 'My orders',
                  subtitle: 'Already have 10 orders',
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
                  title: 'Shipping Addresses',
                  subtitle: '03 Addresses',
                  onTap: () {},
                ),
                ProfileMenuOption(
                  title: 'Payment Method',
                  subtitle: 'You have 2 cards',
                  onTap: () {},
                ),
                ProfileMenuOption(
                  title: 'My reviews',
                  subtitle: 'Reviews for 5 items',
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
                  title: 'Setting',
                  subtitle: 'Notification, Password, FAQ, Contact',
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
