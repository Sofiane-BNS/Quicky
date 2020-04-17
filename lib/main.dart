import 'package:flutter/material.dart';
import 'package:quicky/welcome.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quicky',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Welcome(),
    );
  }
}