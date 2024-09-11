import 'package:flutter/material.dart';
import '../../../shared/app_string.dart';

class SearchWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchWidget({super.key, required this.onChanged});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _controller.clear();
    widget.onChanged(
        ''); // Notify the parent widget that the input has been cleared
    _focusNode.unfocus(); // Dismiss the keyboard
  }

  void _submitSearch(String value) {
    _focusNode.unfocus(); // Dismiss the keyboard when "Done" or "Enter" is pressed
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus(); // Dismiss the keyboard
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _dismissKeyboard, // Dismiss keyboard when tapping outside the TextField
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: _submitSearch, // Dismiss keyboard on Enter/Done key press
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
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.cancel, color: theme.primaryColor),
                        onPressed: _clearSearch,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.dividerColor.withOpacity(0.8),
                    width: 0.1,
                  ),
                ),
                filled: true,
                fillColor: theme.cardColor,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // filteration button
          // Container(
          //   padding: const EdgeInsets.all(8.0),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: theme.dividerColor),
          //     color: theme.cardColor,
          //     borderRadius: BorderRadius.circular(12.0),
          //   ),

          //   child: Icon(
          //     Icons.tune,
          //     size: 30,
          //     color: theme.iconTheme.color,
          //   ),
          // ),
        ],
      ),
    );
  }
}
