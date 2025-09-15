import 'package:flutter/material.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget loadingComponent () {
  return Center(
    child: Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        color: AppColors.priWhite,
        border: Border.all(
          width: 2.0,
          color: AppColors.priBrown
        ),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CircularProgressIndicator(
              color: AppColors.priBrown,
              strokeWidth: 4.0,
            ),
          ),

          SizedBox(height: 16.0,),

          Text(
            "Loading...",
            style: TextStyle(
              color: AppColors.priBrown,
              fontWeight: FontWeight.w600,
              fontSize: 24.0
            ),
          )
        ],
      ),
    ),
  );
}