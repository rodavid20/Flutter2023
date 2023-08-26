import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          title: Text('Iam IIITian'),
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('images/iiit_logo.png'),
            ),
            Text(
              'Alice',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 20.0,
              child: Divider(
                color: Colors.red,
              ),
            ),
            Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('+91 9899000089'),
                ))
          ],
        ),
      ),
    ),
  );
}
