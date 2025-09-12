import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secWhite,
      body: Center(
        child: Column(
          children: [
            Text(
              "Hello"
            ),
            Text(
              "Hello",
              style: TextStyle(
                fontWeight: FontWeight.w400
              ),
            ),
            Text(
              "Hello",
              style: TextStyle(
                fontWeight: FontWeight.w500
              ),
            ),
            Text(
              "Hello",
              style: TextStyle(
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              "Hello",
              style: TextStyle(
                fontWeight: FontWeight.w700
              ),
            ),

            SvgPicture.asset("assets/icons/duration.svg")
          ],
        ),
      ),
    );
  }
}