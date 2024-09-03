import 'package:flutter/material.dart';
import '../../../shared/app_string.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppString.search(context),
              hintStyle: TextStyle(
                color: theme.hintColor,
                fontFamily: 'Montserrat',
              ),
              prefixIcon: Icon(
                Icons.search,
                color: theme.iconTheme.color,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.dividerColor.withOpacity(0.8),
                  width: 0.1,
                ),
              ),
              filled: true,
              fillColor: theme.cardColor,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: theme.dividerColor),
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Icon(
            Icons.tune,
            size: 30,
            color: theme.iconTheme.color,
          ),
        ),
      ],
    );
  }
}
