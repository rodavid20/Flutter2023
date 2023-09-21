import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp(),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var leftImage = '';
  var rightImage = '';
  var leftScore = 0;
  var rightScore = 0;

  @protected
  @mustCallSuper
  @override
  void initState() {
    changeImage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Game'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Player 1'),
                          TextButton(
                            child: Image.asset('images/$leftImage'),
                            onPressed: () {
                              setState(() {
                                changeImage();
                              });
                            },
                          ),
                          Text('Score: $leftScore'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Player 2'),
                          TextButton(
                            child: Image.asset('images/$rightImage'),
                            onPressed: () {
                              setState(() {
                                changeImage();
                              });
                            },
                          ),
                          Text('Score: $rightScore'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: Text('Reset Game'),
                onPressed: () {
                  setState(() {
                    leftScore = 0;
                    rightScore = 0;
                    changeImage();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeImage() {
    leftImage = getImage();
    rightImage = getImage();
    determineWinner();
  }

  String getImage() {
    int number = Random().nextInt(3);
    switch (number) {
      case 0:
        return "stone.png";
      case 1:
        return "paper.png";
      default:
        return "scissors.png";
    }
  }

  void determineWinner() {
    if (leftImage == rightImage) {
      return;
    } else if ((leftImage == 'stone.png' && rightImage == 'scissors.png') ||
        (leftImage == 'scissors.png' && rightImage == 'paper.png') ||
        (leftImage == 'paper.png' && rightImage == 'stone.png')) {
      leftScore += 1;
    } else {
      rightScore += 1;
    }
  }
}
