import 'package:flutter/material.dart';
import 'package:todolist/screen/home_screen.dart';

class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    /*return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new HomeScreen(),
    );*/
    return FutureBuilder(
      // Replace the 3 second delay with your initialization code:
      future: Future.delayed(Duration(seconds: 3),),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomeScreen());
      } );
  }
}
  class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
  body: Center(
  child: Icon(
  Icons.apartment_outlined,
  size: MediaQuery.of(context).size.width * 0.785,
  ),
  ),
  );
  }
  }