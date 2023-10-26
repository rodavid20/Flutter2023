import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Stream<String> loadStreamFromInternet() async* {
    await Future.delayed(const Duration(seconds: 5));
    yield 'First Hello';
    await Future.delayed(const Duration(seconds: 5));
    yield 'Second Hello';
    await Future.delayed(const Duration(seconds: 5));
    yield 'Third Hello';
  }

  Future<String> loadFromInternet() async {
    await Future.delayed(const Duration(seconds: 5));
    return 'Hello From Internet';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: loadFromInternet(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 100,
              width: double.infinity,
            ),
            StreamBuilder(
              stream: loadStreamFromInternet(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!);
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
