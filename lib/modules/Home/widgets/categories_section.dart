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
   late double _buttonWidth=0;

   @override
  void initState() {
    super.initState();
    // Calculate the maximum width for the buttons
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buttonWidth = _calculateMaxButtonWidth(context);
      setState(() {});
    });
  }

  double _calculateMaxButtonWidth(BuildContext context) {
    List<String> labels = [
      AppString.all(context),
      AppString.livingRoom(context),
      AppString.bedRoom(context),
      AppString.decoration(context),
    ];

    double maxWidth = 0;

    for (var label in labels) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            fontSize: 14, // Assuming text size as 14 (adjust as needed)
            fontFamily: 'Montserrat',
          ),
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();

      final width = textPainter.size.width + 40; // Adding some padding space
      if (width > maxWidth) {
        maxWidth = width;
      }
    }

    return maxWidth;
  }

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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryButton(
                  // label: "All",
                  label: AppString.all(context),
                  icon: Icons.redeem,
                  isSelected: _selectedCategory == "all",
                  onTap: () => _onCategorySelected("all"),
                  textSize: textSize, // Pass text size for responsiveness
                  width: _buttonWidth, // Set all buttons to the same width
                  ),
                   const SizedBox(width: 10),
              CategoryButton(
                // label: "Living Room",
                label: AppString.livingRoom(context),
                icon: Icons.living,
                isSelected: _selectedCategory == "Living Room",
                onTap: () => _onCategorySelected("Living Room"),
                textSize: textSize, // Pass text size for responsiveness
                width: _buttonWidth,
              ),
               const SizedBox(width: 10),
              CategoryButton(
                // label: "Bed Room",
                label: AppString.bedRoom(context),
                icon: Icons.bed,
                isSelected: _selectedCategory == "Bed Room",
                onTap: () => _onCategorySelected("Bed Room"),
                textSize: textSize, // Pass text size for responsiveness
                width: _buttonWidth, // Set all buttons to the same width
              ),
               const SizedBox(width: 10),
              CategoryButton(
                // label: "Decoration",
                label: AppString.decoration(context),
                icon: Icons.home,
                isSelected: _selectedCategory == "Decoration",
                onTap: () => _onCategorySelected("Decoration"),
                textSize: textSize, // Pass text size for responsiveness
                width: _buttonWidth,
              ),
            ],
          ),
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
  final double width;

  const CategoryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.textSize, // Add textSize parameter for responsive text
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: isSelected ? 70 : null, // Set a fixed width when selected
        width: width > 0 ? width : null, // Set a fixed width when selected
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
