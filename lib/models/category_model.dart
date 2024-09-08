import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final IconData icon;
  bool isSelected;

  CategoryModel({required this.name, required this.icon, this.isSelected = false});
}

List<CategoryModel> categoryList = [
  CategoryModel(name: "Living Room", icon: Icons.living),
  CategoryModel(name: "Bed Room", icon: Icons.bed),
  CategoryModel(name: "Decoration", icon: Icons.home),
];