import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

import '../../../../models/product_model.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  AddProductCubit() : super(AddProductInitial());

  Future<void> addProduct({
    required String title,
    required double price,
    required int quantity,
    required String description,
    required String category,
    required String imagePath,
  }) async {
    emit(AddProductLoading());
    try {
      // Generate a unique ID for the product
      String productId = const Uuid().v4();

      // Upload the image to Firebase Storage
      File imageFile = File(imagePath);
      String imageUrl = await _uploadImage(productId, imageFile);

      // Create a new product instance
      Product product = Product(
        id: productId,
        imageUrl: imageUrl,
        title: title,
        price: price,
        quantity: quantity,
        description: description,
        category: category,
      );

      // Convert the product to a map and add it to Firestore
      await _firestore.collection('products').doc(product.id).set(product.toMap());

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }

  Future<String> _uploadImage(String productId, File imageFile) async {
    try {
      // Create a reference to Firebase Storage
      Reference storageRef = _storage.ref().child('product_images/$productId');

      // Upload the image file
      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Get the download URL
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }
}
