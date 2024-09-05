import 'package:cloud_firestore/cloud_firestore.dart';
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
import '../../shared/custom_snackbar.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel _currentUserModel;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data when the screen is initialized
  }

  // Function to load user data from SharedPreferences and synchronize with Firebase
  Future<void> _loadUserData() async {
    try {
      final userModel = await UserModel.loadFromPreferences();
      if (userModel != null) {
        setState(() {
          _currentUserModel = userModel;
          _isLoading = false;
        });
      } else {
        // If no user data found in SharedPreferences, fetch from Firebase
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final userDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .get();
          if (userDoc.exists) {
            _currentUserModel = UserModel.fromMap(userDoc.data()!, userDoc.id);
            await _currentUserModel
                .saveToPreferences(); // Save fetched user model to SharedPreferences
            setState(() {
              _isLoading = false;
            });
          }
        }
      }
    } catch (e) {
      // Handle errors appropriately, e.g., show a message or log the error
      CustomSnackbar.show(
        context,
        title: 'Error',
        message: 'Failed to load user data.',
        contentType: ContentType.failure,
      );
      setState(() {
        _isLoading = false;
      });
    }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                double padding = constraints.maxWidth * 0.05;
                return SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileInfo(
                        name: _currentUserModel.userName,
                        email: _currentUserModel.userEmail,
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
                              builder: (context) =>
                                  const AddPaymentMethodScreen(),
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
