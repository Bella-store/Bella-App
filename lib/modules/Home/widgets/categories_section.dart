import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/app_color.dart';
import '../../../shared/app_string.dart';
import '../../Category/categories_selection.dart';
import '../../Products/cubit/all_products_cubit.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  CategoriesSectionState createState() => CategoriesSectionState();
}

class CategoriesSectionState extends State<CategoriesSection> {
  String _selectedCategory = "all"; // Default selected category

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;

      // Trigger the cubit to filter products based on the selected category
      if (category == "all") {
        context.read<AllProductsCubit>().resetProducts();
      } else {
        context.read<AllProductsCubit>().loadProductsByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth =
        MediaQuery.of(context).size.width; // Get the screen width

    // Determine text size based on screen width for responsiveness
    double textSize = screenWidth < 400 ? 12 : 14;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Categories and See All Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.categories(context),
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: textSize + 9, // Adjust title size
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategorySelectionScreen(),
                  ),
                );
              },
              child: Text(
                AppString.seeAll(context),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: textSize, // Adjust text size
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Category buttons row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryButton(
              // label: "All",
              label: AppString.all(context),
              icon: Icons.redeem,
              isSelected: _selectedCategory == "all",
              onTap: () => _onCategorySelected("all"),
              textSize: textSize, // Pass text size for responsiveness
            ),
            CategoryButton(
              // label: "Living Room",
              label: AppString.livingRoom(context),
              icon: Icons.living,
              isSelected: _selectedCategory == "Living Room",
              onTap: () => _onCategorySelected("Living Room"),
              textSize: textSize, // Pass text size for responsiveness
            ),
            CategoryButton(
              // label: "Bed Room",
              label: AppString.bedRoom(context),
              icon: Icons.bed,
              isSelected: _selectedCategory == "Bed Room",
              onTap: () => _onCategorySelected("Bed Room"),
              textSize: textSize, // Pass text size for responsiveness
            ),
            CategoryButton(
              // label: "Decoration",
              label: AppString.decoration(context),
              icon: Icons.home,
              isSelected: _selectedCategory == "Decoration",
              onTap: () => _onCategorySelected("Decoration"),
              textSize: textSize, // Pass text size for responsiveness
            ),
          ],
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final double textSize; // Add textSize parameter for responsive text

  const CategoryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.textSize, // Add textSize parameter for responsive text
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: isSelected ? 70 : null, // Set a fixed width when selected
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.mainColor : theme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : theme.iconTheme.color,
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: textSize, // Use responsive text size
                color: isSelected
                    ? Colors.white
                    : theme.textTheme.bodyLarge?.color,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
