import 'package:bella_app/shared/app_string.dart';
import 'package:flutter/material.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(AppString.chooseCategories(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppString.pleaseChooseOneCategory(context),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(categoryList.length, (index) {
                return CategoryCard(category: categoryList[index]);
              }),
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity,
                          50), // Full width and specific height
                      backgroundColor:
                          theme.primaryColor, // Use theme's primary color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
                      ),
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 18.0, // Consistent font size
                        fontFamily: 'Montserrat', // Font family
                      ),
                    ),
                    child: Text(
                      AppString.submit(context),
                      style: const TextStyle(
                        color: Colors.white, // Ensure text color is white
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: theme.textTheme.labelLarge,
                    ),
                    child: Text(AppString.skip(context)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Category {
  final String name;
  final IconData icon;
  bool isSelected;

  Category({required this.name, required this.icon, this.isSelected = false});
}

class CategoryCard extends StatefulWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  CategoryCardState createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); 

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.category.isSelected = !widget.category.isSelected;
        });
      },
      child: Card(
        color: theme.brightness == Brightness.light
            ? Colors.white
            : theme
                .cardColor, // White background in light mode, default in dark mode
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: widget.category.isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.category.icon,
                color: widget.category.isSelected
                    ? theme.colorScheme.primary
                    : theme.iconTheme.color,
                size: 40,
              ),
              const SizedBox(height: 10),
              Text(
                widget.category.name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: widget.category.isSelected
                      ? theme.textTheme.bodyMedium?.color
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<Category> categoryList = [
  Category(name: "Chair", icon: Icons.chair),
  Category(name: "living", icon: Icons.living),
  Category(name: "bed", icon: Icons.bed),
  Category(name: "weekend", icon: Icons.weekend),
  Category(name: "Sitting", icon: Icons.event_seat),
  Category(name: "Lying", icon: Icons.airline_seat_flat),
  Category(name: "bedroom_child", icon: Icons.bedroom_child),
];
