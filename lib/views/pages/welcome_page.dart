import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/views/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Welcome',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to RistekTodo!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Button buat pergi ke widgetTree
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.ristekPrimaryColor,
              ),
              onPressed: () {
                // Ganti navigator default dr welcome jadi widgetTree
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return WidgetTree();
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child); // Transisi fade biar lebih smooth
                    },
                  ),
                );
              },
              child: const Text(
                'Continue',
                style: Constants.ristekTitleStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
