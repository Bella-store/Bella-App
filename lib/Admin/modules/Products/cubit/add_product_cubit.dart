import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  Future<void> addProduct({
    required String title,
    required double price,
    required double discountedPrice,
    required String description,
    required String category,
    required List<String> imagePaths,
  }) async {
    emit(AddProductLoading());

    try {
      // Upload images to Firebase Storage and get the URLs
      List<String> imageUrls = [];
      for (var path in imagePaths) {
        final ref = FirebaseStorage.instance.ref().child('products/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(File(path));
        final url = await ref.getDownloadURL();
        imageUrls.add(url);
      }

      // Add the product to Firestore (assuming you have a Firestore setup)
      await FirebaseFirestore.instance.collection('products').add({
        'title': title,
        'price': price,
        'discountedPrice': discountedPrice,
        'description': description,
        'category': category,
        'imageUrls': imageUrls,
        'createdAt': DateTime.now(),
      });

      emit(AddProductSuccess());
    } catch (e) {
      emit(AddProductFailure(e.toString()));
    }
  }
}
