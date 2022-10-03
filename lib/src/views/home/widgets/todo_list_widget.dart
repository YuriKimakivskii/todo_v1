import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/todo_provider.dart';
import 'todo_row_widget.dart';

class TodoListWidget extends StatelessWidget {
  const TodoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        var todoList = todoProvider.todoListGroupByDate;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return TodoRowWidget(
                          indexInList: index,
                          todo: todoList[index],
                        );
                      },
                      itemCount: todoList.length),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
