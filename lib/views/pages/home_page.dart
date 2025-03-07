import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/views/pages/add_todo_page.dart';
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
                DateFormat('EEEE, MMMM dd yyyy').format(DateTime.now()), // Tampilkan hari, bulan, tanggal, dan tahun
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF474747),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ValueListenableBuilder(
                valueListenable: nicknameNotifier,
                builder: (context, value, child) {
                  return Text(
                    'Welcome ${nicknameNotifier.value.isEmpty ? 'John' : nicknameNotifier.value}!',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                },
              ),
              Text(
                'Have a nice day !',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF474747),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Tasks',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Constants.ristekPrimaryColor,
                      ),
                      minimumSize: WidgetStateProperty.all<Size>(
                        Size(80, 30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddTodoPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Add Task',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: ValueListenableBuilder(
              valueListenable: todoListNotifier,
              builder: (context, value, child) {
                return ListView.builder( // Tampilkan list todo
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
