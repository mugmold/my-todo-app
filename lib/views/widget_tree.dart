import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/controllers.dart';
import 'package:my_todo_app/data/notifiers.dart';
import 'package:my_todo_app/views/pages/about_me_page.dart';
import 'package:my_todo_app/views/pages/home_page.dart';
import 'package:my_todo_app/views/widgets/navbar_widget.dart';

// Menyimpan daftar page dan namanya untuk ditampilkan di UI
List<Widget> pages = [
  HomePage(),
  AboutMePage(),
];

List<AppBar> pagesAppBar = [
  AppBar(
    backgroundColor: Colors.white,
  ),
  AppBar(
    backgroundColor: Constants.ristekPrimaryColor,
    title: Text(
      'My profile',
      style: Constants.ristekTitleStyle,
    ),
    centerTitle: true,
  ),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ValueListenableBuilder<int>(
          valueListenable: selectedPage,
          builder: (context, value, child) {
            return pagesAppBar[value];
          },
        ),
      ),
      bottomNavigationBar: NavbarWidget(),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          selectedPage.value = value;
        },
        children: pages,
      ),
    );
  }
}
