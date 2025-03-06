import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/data/todo.dart';
import 'package:my_todo_app/data/todo_database.dart';
import 'package:my_todo_app/views/widgets/todo_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF474747),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Welcome User',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Have a nice day !',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF474747),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: EdgeInsets.all(10),
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
              ),
              onEditingComplete: () async {
                if (controller.text.isNotEmpty) {
                  Todo todo = Todo(name: controller.text);
                  await TodoDatabase.addTodo(todo);
                  controller.text = '';
                  setState(() {});
                }
              },
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ValueListenableBuilder(
              valueListenable: todoList,
              builder: (context, value, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TodoWidget(
                        taskName: value[index].name,
                        isComplete: value[index].isComplete,
                        index: index,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
