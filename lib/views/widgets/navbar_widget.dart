import 'package:flutter/material.dart';
import 'package:my_todo_app/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPage,
      builder: (context, value, child) {
        return NavigationBar(
          destinations: [
            Padding(
              // memisahkan icon berdasarkan lebar screen
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.2),
              child: NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.2),
              child: NavigationDestination(
                icon: Icon(Icons.person),
                label: 'About me',
              ),
            ),
          ],
          selectedIndex: value,
          onDestinationSelected: (value) {
            selectedPage.value = value;
          },
        );
      },
    );
  }
}
