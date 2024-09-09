import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String userId;
  final String userName;
  final String userEmail;
  List<String> favoriteProducts; // List of product IDs
  List<Map<String, dynamic>> cartProducts; // List of cart product IDs
  final String role;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.favoriteProducts,
    required this.cartProducts,
    required this.role,
  });

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromMap(Map<String, dynamic> data, String userId) {
    return UserModel(
      userId: userId,
      userName: data['userName'] ?? '',
      userEmail: data['userEmail'] ?? '',
      favoriteProducts: List<String>.from(data['favoriteProducts'] ?? []),
      cartProducts: List<Map<String, dynamic>>.from(data['cartProducts'] ?? []),
      role: data['role'] ?? 'user',
    );
  }

  // Convert UserModel to a map to save in Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userEmail': userEmail,
      'favoriteProducts': favoriteProducts,
      'cartProducts': cartProducts,
      'role': role,
    };
  }

  // Save the UserModel to SharedPreferences as a JSON string
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(toMap());
    await prefs.setString('userModel', userJson);
  }

  // Load the UserModel from SharedPreferences
  static Future<UserModel?> loadFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('userModel');
    if (userJson != null) {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromMap(userMap, userMap['userId']);
    }
    return null;
  }

  // Clear the UserModel from SharedPreferences
  static Future<void> clearFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userModel');
  }

  // Update cartProducts and save to SharedPreferences
  Future<void> updateCartProducts(
      List<Map<String, dynamic>> newCartProducts) async {
    cartProducts = newCartProducts;
    await saveToPreferences(); // Save updated model to SharedPreferences
  }

  // Update favoriteProducts and save to SharedPreferences
  Future<void> updateFavoriteProducts(List<String> newFavoriteProducts) async {
    favoriteProducts = newFavoriteProducts;
    await saveToPreferences(); // Save updated model to SharedPreferences
  }

  // Method to clear cart products from user model
  Future<void> clearCartProducts() async {
    cartProducts = []; // Clear the cartProducts list
    await saveToPreferences(); // Save the updated user model back to SharedPreferences
  }
}
