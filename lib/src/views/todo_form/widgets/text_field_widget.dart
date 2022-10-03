import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';
import '../../../utils/app_colors.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.maxLineCount,
    required this.hintText,
    this.onChanged,
    this.suffixIcon,
    required this.readOnly,
  }) : super(key: key);
  final TextEditingController? controller;
  final int maxLineCount;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final IconButton? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return TextField(
          readOnly: readOnly,
          maxLines: maxLineCount,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.getMaterialColorFromColor(
                    themeProvider.selectedForegroundColor),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            filled: true,
            hintText: hintText,
          ),
          onChanged: onChanged,
        );
      },
    );
  }
}
