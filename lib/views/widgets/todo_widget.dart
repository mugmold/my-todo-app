import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/todo_database.dart';
import 'package:my_todo_app/views/pages/view_todo_page.dart';
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

  // Dispose buat mengatasi memory leak
  @override
  void dispose() {
    taskComplete.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: taskComplete,
      builder: (context, value, child) {
        return InkWell(
          onTap: () async {
            await TodoDatabase.toggleTodoButton(widget.index);
            taskComplete.value = !taskComplete.value;
          },
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewTodoPage(
                  index: widget.index,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Constants.primaryTransparent,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: Text(
                    widget.taskName,
                    style: TextStyle(
                      color: taskComplete.value
                          ? Constants.primaryColor
                          : Color(0xFF4A4646),
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: taskComplete,
                  builder: (context, value, child) {
                    return CheckboxWidget(
                      value: value,
                      onChanged: () async {
                        await TodoDatabase.toggleTodoButton(
                          widget.index,
                        ); // Toggle status todo
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
