import 'dart:convert';

import 'package:my_todo_app/data/todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoDatabase {
  static Future<void> saveTodos(List<Todo> newTodoList) async {
    final prefs = await SharedPreferences.getInstance();
    final todoList =
        newTodoList.map((todo) => jsonEncode(todo.toMap())).toList();
    await prefs.setStringList('todos', todoList);
  }

  static Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todoList = prefs.getStringList('todos') ?? [];
    return todoList
        .map((todo) => Todo.fromMapToTodo(jsonDecode(todo)))
        .toList();
  }

  static Future<void> addTodo(Todo todo) async {
    final todoList = await loadTodos();
    todoList.add(todo);
    await saveTodos(todoList);
  }

  static Future<void> removeTodo(int index) async {
    final todoList = await loadTodos();
    todoList.removeAt(index);
    await saveTodos(todoList);
  }

  static Future<void> toggleTodoButton(int index) async {
    final todoList = await loadTodos();
    todoList[index].isComplete = !todoList[index].isComplete;
    await saveTodos(todoList);
  }
}
