import 'package:flutter/material.dart';
import 'package:my_todo_app/data/todo.dart';

// Notifier untuk menentukan halaman yang dipilih dalam widget tree
// Defaultnya set ke 0 (Todo page)
ValueNotifier<int> selectedPage = ValueNotifier(0);

// Notifier untuk nampung list Todo
// buat bug fixing ketika todoList kurang sinkron dengan shared preferences akibat delay
ValueNotifier<List<Todo>> todoListNotifier = ValueNotifier([]);

// Notifier untuk data pribadi
// buat bug fixing ketika data kuran sinkron dengan shared preferences akibat delay
ValueNotifier<String> fullNameNotifier = ValueNotifier('');
ValueNotifier<String> nicknameNotifier = ValueNotifier('');
ValueNotifier<String> hobbiesNotifier = ValueNotifier('');
ValueNotifier<String> socialMediaNotifier = ValueNotifier('');