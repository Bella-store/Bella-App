import 'package:flutter/material.dart';

import '../../../shared/app_string.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: AppString.search(context),
              hintStyle: TextStyle(
                color: Colors.grey[500],
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.8),
                  width: 0.1,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            ),
          ),
        ),
        const SizedBox(width: 8.0), 
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Icon(
            Icons.tune,
            size: 30,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
