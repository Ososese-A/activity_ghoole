import 'package:flutter/material.dart';
import 'package:project_ghoole/screens/main_screen.dart';
import 'package:project_ghoole/screens/my_activities_screen.dart';

void main() {
  runApp(const Ghoole());
}

class Ghoole extends StatelessWidget {
  const Ghoole({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Raleway'),
      initialRoute: '/activities',
      routes: {
        '/home': (context) => MainScreen(),
        '/activities': (context) => MyActivitiesScreen()
      },
    );
  }
}