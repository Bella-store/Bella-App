import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../Admin/modules/Products/add_products_screen.dart';
import '../../models/user_model.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/products_section.dart';
import 'widgets/search_bar.dart';
import 'widgets/categories_section.dart';

class HomeScreen extends StatefulWidget {
  final PersistentTabController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String searchTerm = ''; // Holds the current search term
  UserModel? userModel;
  @override
  void initState() {
    super.initState();
    getUser(); // Call getUser to load user data when the screen is initialized
  }

  Future<void> getUser() async {
    try {
      userModel = await UserModel
          .loadFromPreferences(); // Load the user model from SharedPreferences
      if (userModel != null) {
        setState(() {}); // Trigger a rebuild to display the loaded data
      } else {
        if (kDebugMode) {
          print("No user data found in SharedPreferences");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading user data: $e");
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: userModel?.role == "admin"?FloatingActionButton(
        heroTag: 'home_fab', // Unique heroTag for Home screen
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ):null,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pass the PageController to the CustomAppBar for navigation purposes
                  CustomAppBar(
                    screenSize: MediaQuery.of(context).size,
                    navController: widget.controller,
                  ),
                  const SizedBox(height: 20),
                  // SearchWidget with a callback to update the searchTerm
                  SearchWidget(
                    onChanged: (value) {
                      setState(() {
                        searchTerm = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const CategoriesSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Pass the searchTerm to ProductsSection
          SliverToBoxAdapter(
            child: ProductsSection(searchTerm: searchTerm),
          ),
        ],
      ),
    );
  }
}
