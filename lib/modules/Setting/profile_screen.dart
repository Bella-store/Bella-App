import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bella_app/modules/Favorites/favorites_screen.dart';
import 'package:bella_app/modules/Setting/add_payment_method_screen.dart';
import 'package:bella_app/shared/local/languages/app_localizations.dart';
import '../../shared/app_string.dart';
import '../Auth/login/login_screen.dart';
import 'myorder_screen.dart';
import 'reviews_screen.dart';
import 'setting_screen.dart';
import 'widgets/profile_info.dart';
import 'widgets/profile_menu_option.dart';
import '../../shared/custom_snackbar.dart'; // Import CustomSnackbar

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Bella User"; // Default value
  String userEmail = "bella@gmail.com"; // Default value

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data from SharedPreferences
  }

  // Function to load user data from SharedPreferences
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? "Bella User";
      userEmail = prefs.getString('userEmail') ?? "bella@gmail.com";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'.tr(context),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
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
                  name: userName, // Display the actual user name
                  email: userEmail, // Display the actual user email
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
                  title: AppString.favorites(context),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoritesScreen(),
                      ),
                    );
                  },
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
          title: Text(AppString.logout(context)),
          content: Text(AppString.areYouSureLogout(context)),
          actions: <Widget>[
            TextButton(
              child: Text(AppString.cancel(context)),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text(AppString.logout(context),
                  style: const TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                // Firebase sign out
                await FirebaseAuth.instance.signOut();

                // Clear SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                // Show a snackbar message using CustomSnackbar
                CustomSnackbar.show(
                  context,
                  title: 'Success',
                  message: 'Successfully logged out',
                  contentType: ContentType.success,
                );

                // Navigate to the login screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
