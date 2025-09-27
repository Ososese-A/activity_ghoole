import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

Widget tagBtnComponent ({required String title, required String icon, required VoidCallback onPressed, required bool isSelected}) {
  return GestureDetector(
    onTap: onPressed,
    child: IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32.0),
        // width: 192.0,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secBrown : Colors.transparent,
          border: Border.all(
            width: 1,
            color: AppColors.secBrown
          ),
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset("assets/icons/design.svg"),
            SvgPicture.asset(
              icon,
              height: 16.0,
              width: 16.0,
            ),
            SizedBox(width: 8.0,),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.0,
                color: isSelected ? AppColors.secWhite : AppColors.secBrown
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget altBtnComponent ({required VoidCallback onPressed, required String title, required String icon}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 140.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0
        ),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            // "assets/icons/ongoing.svg"
            icon,
            height: 16.0,
            width: 16.0,
          ),

          SizedBox(width: 8.0,),

          Text(
            // "Ongoing",
            title,
            style: TextStyle(
              color: AppColors.priBrown,
              fontSize: 16.0
            ),
          )
        ],
      ),
    ),
  );
}