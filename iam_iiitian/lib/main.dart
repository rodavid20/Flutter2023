import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text('Iam IIITian'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60.0,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('images/iiit_logo.png'),
            ),
            SizedBox(
              width: 150.0,
              height: 20.0,
            ),
            Text(
              'Alice',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Pacifico',
                color: Colors.white,
                letterSpacing: 2.5,
              ),
            ),
            Text(
              '5th Semester B. Tech.',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal[100],
                letterSpacing: 2.5,
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 20.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20.0),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text('+91 9899000089'),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text('alice.123@gmail.com'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
