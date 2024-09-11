import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class UserModel {
  final String userId;
  final String userName;
  final String userEmail;
  final String userImage; // New field for user image
  final String address; // New field for address
  final String phone; // New field for phone
  List<String> favoriteProducts; // List of product IDs
  List<Map<String, dynamic>> cartProducts; // List of cart product IDs
  final String role;

  UserModel({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userImage = '', // Default value for user image
    this.address = "Ex:-Ismailia", // Default value for address
    this.phone = "Ex:-201025879212", // Default value for phone
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
      userImage: data['userImage'] ?? '',
      address: data['address'] ?? 'Ex:-Ismailia',
      phone: data['phone'] ?? 'Ex:-201025879212',
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
      'userImage': userImage,
      'address': address,
      'phone': phone,
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

  // Method to update the UserModel with new values using copyWith
  UserModel copyWith({
    String? userName,
    String? userEmail,
    String? userImage,
    String? address,
    String? phone,
    List<String>? favoriteProducts,
    List<Map<String, dynamic>>? cartProducts,
    String? role,
  }) {
    return UserModel(
      userId: userId,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      userImage: userImage ?? this.userImage,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      cartProducts: cartProducts ?? this.cartProducts,
      role: role ?? this.role,
    );
  }
}
