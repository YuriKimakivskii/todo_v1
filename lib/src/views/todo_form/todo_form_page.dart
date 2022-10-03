import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/date_and_time.dart';
import 'widgets/date_picker_widget.dart';
import 'widgets/save_todo_button_widget.dart';
import 'widgets/time_picker_widget.dart';
import 'widgets/todo_note_text_field.dart';
import 'widgets/todo_title_text_field.dart';

class TodoFormPage extends StatelessWidget {
  const TodoFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController noteController = TextEditingController();
    TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd', 'uk').format(DateAndTime.selectedDate),
    );
    TextEditingController timeController =
        TextEditingController(text: DateAndTime.getFromatTime(TimeOfDay.now()));
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Створити запис',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TodoTitleTextField(titleController: titleController),
            TodoNoteTextField(noteController: noteController),
            Row(
              children: [
                DatePickerWidget(dateController: dateController),
                TimePickerWidget(timeController: timeController),
              ],
            ),
            SaveTaskButtonWidget(
              titleController: titleController,
              noteController: noteController,
              dateController: dateController,
              timeController: timeController,
            ),
          ],
        ),
      ),
    );
  }
}
