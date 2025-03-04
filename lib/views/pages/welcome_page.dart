import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/views/widget_tree.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.ristekBackgroundColor,
        title: const Text(
          'Welcome',
          style: Constants.ristekTitleStyle,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to My Todo App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Button buat pergi ke widgetTree
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.ristekBackgroundColor,
              ),
              onPressed: () {
                // Ganti navigator default dr welcome jadi widgetTree
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WidgetTree(); // Pergi ke WidgetTree sebagai struktur navigasi utama di app
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
