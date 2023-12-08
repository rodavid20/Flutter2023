import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(counter.toString(),
              style: Theme.of(context).textTheme.headlineLarge),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  counter--;
                });
              },
              child: Icon(Icons.remove),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              child: Icon(Icons.add),
            )
          ],
        )
      ],
    );
  }
}
