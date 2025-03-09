import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/views/pages/edit_todo_page.dart';

class ViewTodoPage extends StatefulWidget {
  const ViewTodoPage({
    super.key,
    required this.index, // Index todo yang mau diedit
  });

  final int index;

  @override
  State<ViewTodoPage> createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  TextEditingController controllerName =
      TextEditingController(); // Controller buat ambil nama task
  TextEditingController controllerDescription =
      TextEditingController(); // Controller buat ambil deskripsi task

  // Inisialisasi controller dengan value todo yang mau diedit
  @override
  void initState() {
    super.initState();
    controllerName.text = todoListNotifier.value[widget.index].name;
    controllerDescription.text =
        todoListNotifier.value[widget.index].description;
  }

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
                    'View Task',
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
                        enabled: false,
                        controller: controllerName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        onEditingComplete: () async {
                          FocusScope.of(context).unfocus(); // Tutup keyboard
                        },
                      ),
                    ),
                    SizedBox(
                      height: 35,
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
                        enabled: false,
                        controller: controllerDescription,
                        decoration: InputDecoration(
                          hintText: controllerDescription.text.isEmpty
                              ? 'The description is empty'
                              : '',
                          hintStyle: TextStyle(
                            fontStyle: FontStyle.italic
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10.0),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTodoPage(
                              index: widget.index,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Edit Task',
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
