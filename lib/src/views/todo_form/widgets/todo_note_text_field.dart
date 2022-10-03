import 'package:flutter/material.dart';

import 'text_field_widget.dart';

class TodoNoteTextField extends StatelessWidget {
  const TodoNoteTextField({Key? key, required this.noteController})
      : super(key: key);
  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Нотатки',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          TextFieldWidget(
            readOnly: false,
            controller: noteController,
            maxLineCount: 4,
            hintText: 'Тут Ви можете записати додаткову інформацію.',
          ),
        ],
      ),
    );
  }
}
