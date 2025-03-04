import 'package:flutter/material.dart';

// Notifier untuk menentukan halaman yang dipilih dalam widget tree
// Defaultnya set ke 0 (Todo page)
ValueNotifier<int> selectedPage = ValueNotifier(0);