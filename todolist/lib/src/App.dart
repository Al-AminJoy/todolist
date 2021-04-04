import 'package:flutter/material.dart';
import 'package:todolist/screen/home_screen.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomeScreen(),
    );

  }
}
