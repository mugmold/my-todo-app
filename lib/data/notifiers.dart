import 'package:flutter/material.dart';
import 'package:my_todo_app/data/todo.dart';

// Notifier untuk menentukan halaman yang dipilih dalam widget tree
// Defaultnya set ke 0 (Todo page)
ValueNotifier<int> selectedPage = ValueNotifier(0);
ValueNotifier<List<Todo>> todoList = ValueNotifier([]);
