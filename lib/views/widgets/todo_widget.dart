import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/todo_database.dart';
import 'package:my_todo_app/views/pages/edit_todo_page.dart';
import 'package:my_todo_app/views/widgets/checkbox_widget.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({
    super.key,
    required this.taskName,
    required this.isComplete,
    required this.index,
  });

  final String taskName;
  final bool isComplete;
  final int index;

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  late ValueNotifier<bool> taskComplete;

  @override
  void initState() {
    super.initState();
    taskComplete = ValueNotifier(widget.isComplete);
  }

  @override
  void dispose() {
    super.dispose();
    taskComplete.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: taskComplete,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () async {
            await TodoDatabase.toggleTodoButton(widget.index);
            taskComplete.value = !taskComplete.value;
          },
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditTodoPage(
                  index: widget.index,
                ),
              ),
            );
          },
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.taskName),
                ValueListenableBuilder(
                  valueListenable: taskComplete,
                  builder: (context, value, child) {
                    return CheckboxWidget(
                      value: value,
                      onChanged: () async {
                        await TodoDatabase.toggleTodoButton(widget.index);
                        taskComplete.value = !taskComplete.value;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
