import 'package:flutter/material.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget btnComponent ({required VoidCallback onPressed, required String title}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
      decoration: BoxDecoration(
        color: AppColors.priBrown,
        borderRadius: BorderRadius.circular(4.0)
      ),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.priWhite,
          fontSize: 20.0,
          fontWeight: FontWeight.w600
        ),
      ),
    ),
  );
}

Widget txtBtnComponent ({required VoidCallback onTap, required String title}) {
  return TextButton(
    onPressed: onTap, 
    child: Text(
      title,
      style: TextStyle(
        color: AppColors.priBrown,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationColor: AppColors.priBrown,
        decorationThickness: 2.0
      ),
    )
  );
}