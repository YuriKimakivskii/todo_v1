import 'package:flutter/material.dart';

import 'text_field_widget.dart';

class TodoTitleTextField extends StatelessWidget {
  const TodoTitleTextField({Key? key, required this.titleController})
      : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Заголовок',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          TextFieldWidget(
            readOnly: false,
            controller: titleController,
            maxLineCount: 1,
            hintText: 'Введіть заголовок',
            onChanged: null,
          ),
        ],
      ),
    );
  }
}
