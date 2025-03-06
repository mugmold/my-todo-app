import 'dart:convert';

import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/data/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoDatabase {
  static Future<void> saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListString =
        todoList.value.map((todo) => jsonEncode(todo.toMap())).toList();
    await prefs.setStringList('todos', todoListString);
  }

  static Future<void> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoListString = prefs.getStringList('todos') ?? [];
    todoList.value = todoListString
        .map((todo) => Todo.fromMapToTodo(jsonDecode(todo)))
        .toList();
  }

  static Future<void> addTodo(Todo todo) async {
    todoList.value.add(todo);
    await saveTodos();
  }

  static Future<void> editTodo(int index, Todo newTodo) async {
    todoList.value[index].name = newTodo.name;
    await saveTodos();
  }

  static Future<void> removeTodo(int index) async {
    todoList.value.removeAt(index);
    await saveTodos();
  }

  static Future<void> toggleTodoButton(int index) async {
    todoList.value[index].isComplete = !todoList.value[index].isComplete;
    await saveTodos();
  }
}
