import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/todo_model.dart';
import '../utils/date_and_time.dart';

class TodoProvider extends ChangeNotifier {
  TodoProvider() {
    setup();
  }

  int id = 0;
  String title = '';
  String note = '';
  String date = '';
  String time = '';
  bool isDone = false;

  DateTime now =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  var _todoList = <TodoModel>[];
  var todoListGroupByDate = <TodoModel>[];

  List<TodoModel> get todoList => _todoList.toList();

  List<TodoModel> getTodoList(DateTime dateTime) {
    return _todoList
        .where((task) =>
            DateTime.parse(task.date).year == dateTime.year &&
            DateTime.parse(task.date).month == dateTime.month &&
            DateTime.parse(task.date).day == dateTime.day)
        .toList();
  }

  _readTodoListFromHive(Box<TodoModel> box) {
    String date = DateAndTime.selectedDate.toString();
    _todoList = box.values.toList();
    todoListGroupByDate =
        box.values.where((todo) => todo.date == date).toList();
    notifyListeners();
  }

  void setup() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TodoModelAdapter());
    }

    final box = await Hive.openBox<TodoModel>('todo_box');
    // await box.deleteFromDisk();
    _readTodoListFromHive(box);
    box.listenable().addListener(() => _readTodoListFromHive(box));
    notifyListeners();
  }

  int getCountTask(DateTime dateTime) {
    int count = _todoList
        .where((task) =>
            DateTime.parse(task.date).year == dateTime.year &&
            DateTime.parse(task.date).month == dateTime.month &&
            DateTime.parse(task.date).day == dateTime.day)
        .length;
    return count;
  }

  addTodo(TodoModel todo) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TodoModelAdapter());
    }

    final box = await Hive.openBox<TodoModel>('todo_box');

    await box.put(todo.id, todo);
  }

  deleteTodo(String key) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TodoModelAdapter());
    }

    final box = await Hive.openBox<TodoModel>('todo_box');
    await box.delete(key);
  }

  void changeIsDone(String key, bool isDone) async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TodoModelAdapter());
    }

    final box = await Hive.openBox<TodoModel>('todo_box');

    var todo = box.get(key);
    if (todo != null) {
      todo.isDone = isDone;
      box.put(key, todo);
    }
  }
}
