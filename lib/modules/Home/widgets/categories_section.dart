import 'package:flutter/material.dart';
import '../../../shared/app_color.dart';
import '../../../shared/app_string.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  CategoriesSectionState createState() => CategoriesSectionState();
}

class CategoriesSectionState extends State<CategoriesSection> {
  String _selectedCategory = "Chair"; // Default selected category

  void _onCategorySelected(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppString.categories(context),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
            Text(
              AppString.seeAll(context),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CategoryButton(
              label: "Chair",
              icon: Icons.chair,
              isSelected: _selectedCategory == "Chair",
              onTap: () => _onCategorySelected("Chair"),
            ),
            CategoryButton(
              label: "Table",
              icon: Icons.table_bar,
              isSelected: _selectedCategory == "Table",
              onTap: () => _onCategorySelected("Table"),
            ),
            CategoryButton(
              label: "Sofa",
              icon: Icons.weekend,
              isSelected: _selectedCategory == "Sofa",
              onTap: () => _onCategorySelected("Sofa"),
            ),
            CategoryButton(
              label: "Bed",
              icon: Icons.bed,
              isSelected: _selectedCategory == "Bed",
              onTap: () => _onCategorySelected("Bed"),
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

  const CategoryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.mainColor : theme.cardColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : theme.iconTheme.color),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : theme.textTheme.bodyLarge?.color,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
