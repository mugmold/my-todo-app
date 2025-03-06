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
  TextEditingController controller = TextEditingController();
  String errorText = '';

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.ristekPrimaryColor,
      body: Column(
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
                alignment: Alignment.topCenter, // Paksa ke tengah atas
                child: Padding(
                  padding: EdgeInsets.only(top: 50), // Sama kayak back button
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
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'type something...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10.0),
                      ),
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus(); // Tutup keyboard
                        if (controller.text.isNotEmpty) {
                          Todo todo = Todo(name: controller.text);
                          await TodoDatabase.addTodo(todo);
                          if (context.mounted) {
                            Navigator.pushAndRemoveUntil(
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
                      if (controller.text.isNotEmpty) {
                        Todo todo = Todo(name: controller.text);
                        await TodoDatabase.addTodo(todo);
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
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
        ],
      ),
    );
  }
}
