import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Game'),
        ),
        body: Center(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    child: Image.asset('images/paper.png'),
                    onPressed: () {
                      print('left button clicked');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextButton(
                    child: Image.asset('images/scissors.png'),
                    onPressed: () {
                      print('right button clicked');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
