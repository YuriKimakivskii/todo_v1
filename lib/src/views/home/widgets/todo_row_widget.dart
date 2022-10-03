import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../../models/todo_model.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/todo_provider.dart';
import '../../../utils/app_colors.dart';

class TodoRowWidget extends StatelessWidget {
  const TodoRowWidget({
    Key? key,
    required this.indexInList,
    required this.todo,
  }) : super(key: key);
  final int indexInList;
  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, ThemeProvider>(
      builder: (context, todoProvider, themeProvider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: Material(
            elevation: 20,
            child: Slidable(
              key: const ValueKey(0),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                dismissible: DismissiblePane(onDismissed: () {
                  todoProvider.deleteTodo(todo.id);
                }),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      todoProvider.deleteTodo(todo.id);
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Видалити',
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  key: key,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: todo.isDone
                        ? Colors.grey
                        : AppColors.getMaterialColorFromColor(
                            themeProvider.selectedForegroundColor),
                    child: Text(
                      todo.time,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    todo.title,
                    style: todo.isDone
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : const TextStyle(decoration: TextDecoration.none),
                    maxLines: 4,
                  ),
                  subtitle: Text(
                    todo.note,
                    style: todo.isDone
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : const TextStyle(decoration: TextDecoration.none),
                  ),
                  trailing: Checkbox(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    activeColor: Colors.grey,
                    value: todo.isDone,
                    onChanged: (value) =>
                        todoProvider.changeIsDone(todo.id, value!),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
