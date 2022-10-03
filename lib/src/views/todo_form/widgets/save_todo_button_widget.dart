import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_model.dart';
import '../../../providers/todo_provider.dart';

class SaveTaskButtonWidget extends StatelessWidget {
  const SaveTaskButtonWidget({
    Key? key,
    required this.titleController,
    required this.noteController,
    required this.dateController,
    required this.timeController,
  }) : super(key: key);
  final TextEditingController titleController;
  final TextEditingController noteController;
  final TextEditingController dateController;
  final TextEditingController timeController;

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(builder: (context, todoProvider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10),
            child: ElevatedButton(
              onPressed: () {
                final todo = TodoModel(
                  id: UniqueKey().toString(),
                  title: titleController.text,
                  note: noteController.text,
                  date: '${dateController.text} 00:00:00.000',
                  time: timeController.text,
                  isDone: false,
                );
                todoProvider.addTodo(todo);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                // backgroundColor: MaterialStateProperty.all(ThemeProvider.secondaryColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Зберегти',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
