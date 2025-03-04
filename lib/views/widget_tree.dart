import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/views/pages/about_me_page.dart';
import 'package:my_todo_app/views/pages/home_page.dart';
import 'package:my_todo_app/views/widgets/navbar_widget.dart';

// Menyimpan daftar page dan namanya untuk ditampilkan di UI
List<Widget> pages = [
  HomePage(),
  AboutMePage(),
];

List<String> pagesName = [
  'To do',
  'About me',
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.ristekBackgroundColor,
        leading: Padding(
          padding: EdgeInsets.all(10.0),
          child: Image.asset('assets/images/icon.png'),
        ),
        title: ValueListenableBuilder(
          valueListenable: selectedPage,
          builder: (context, value, child) {
            return Text(
              pagesName[value],
              style: Constants.ristekTitleStyle,
            );
          },
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: selectedPage,
        builder: (context, value, child) {
          return pages[value];
        },
      ),
    );
  }
}
