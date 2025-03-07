import 'dart:convert';

import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/data/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Class buat simpan dan load data todo
class TodoDatabase {
  static Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListString =
        todoListNotifier.value.map((todo) => jsonEncode(todo.toMap())).toList();
    await prefs.setStringList('todos', todoListString);
  }

  static Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListString = prefs.getStringList('todos') ?? [];
    todoListNotifier.value = todoListString
        .map((todo) => Todo.fromMapToTodo(jsonDecode(todo)))
        .toList();
  }

  static Future<void> addTodo(Todo todo) async {
    todoListNotifier.value.add(todo);
    await saveTodos();
  }

  static Future<void> editTodo(int index, Todo newTodo) async {
    todoListNotifier.value[index].name = newTodo.name;
    await saveTodos();
  }

  static Future<void> removeTodo(int index) async {
    todoListNotifier.value.removeAt(index);
    await saveTodos();
  }

  static Future<void> toggleTodoButton(int index) async {
    todoListNotifier.value[index].isComplete = !todoListNotifier.value[index].isComplete;
    await saveTodos();
  }
}
