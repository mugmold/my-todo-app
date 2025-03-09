import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/todo.dart';
import 'package:my_todo_app/data/todo_database.dart';
import 'package:my_todo_app/views/widget_tree.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController controllerName =
      TextEditingController(); // Controller buat ambil nama task
  TextEditingController controllerDescription =
      TextEditingController(); // Controller buat ambil deskripsi task
  String errorText = '';

  // Dispose buat mengatasi memory leak
  @override
  void dispose() {
    controllerName.dispose();
    controllerDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.ristekPrimaryColor,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 40,
                    left: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        size: 20,
                        color: Constants.ristekPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 14, bottom: 5),
                      child: Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Constants.ristekPrimaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Constants.ristekPrimaryTransparent,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          hintText: 'type something...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[400],
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onEditingComplete: () async {
                          FocusScope.of(context).unfocus(); // Tutup keyboard
                        },
                      ),
                    ),
                    Text(
                      errorText,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 14, bottom: 5),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Constants.ristekPrimaryColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Constants.ristekPrimaryTransparent,
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        controller: controllerDescription,
                        decoration: InputDecoration(
                          hintText: 'type something...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[400],
                          ),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onEditingComplete: () async {
                          FocusScope.of(context).unfocus(); // Tutup keyboard
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                          Constants.ristekPrimaryColor,
                        ),
                        minimumSize: WidgetStateProperty.all<Size>(
                          Size(double.infinity, 50),
                        ),
                        shape: WidgetStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (controllerName.text.isNotEmpty) {
                          Todo todo = Todo(
                            name: controllerName.text,
                            description: controllerDescription.text,
                          );
                          await TodoDatabase.addTodo(todo);
                          if (context.mounted) {
                            // Cek apakah widget masih ada di tree
                            Navigator.pushAndRemoveUntil(
                              // Pindah ke halaman lain dan hapus semua halaman sebelumnya
                              context,
                              MaterialPageRoute(
                                builder: (context) => WidgetTree(
                                  message: 'Task added successfully!',
                                ),
                              ),
                              (route) => false,
                            );
                          }
                        } else {
                          setState(
                            () {
                              errorText = 'Title cannot be empty!';
                            },
                          );
                        }
                      },
                      child: Text(
                        'Create Task',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
