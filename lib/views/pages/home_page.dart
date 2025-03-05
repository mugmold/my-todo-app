import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/todo.dart';
import 'package:my_todo_app/data/todo_database.dart';
import 'package:my_todo_app/views/widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<Todo> todoList = [];

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadTodoList();
  }

  void loadTodoList() async {
    List<Todo> data = await TodoDatabase.loadTodos();
    setState(() {
      todoList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(15),
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
                      hintText: todoList.length.toString(),
                    ),
                    onEditingComplete: () async {
                      if (controller.text.isNotEmpty) {
                        Todo todo = Todo(name: controller.text);
                        await TodoDatabase.addTodo(todo);
                        controller.text = '';
                        loadTodoList();
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TodoWidget(
                            taskName: todoList[index].name,
                            isComplete: todoList[index].isComplete,
                            index: index,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
