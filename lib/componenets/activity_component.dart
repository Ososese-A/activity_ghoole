import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget activityComponent () {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: AppColors.secBrown
        ),
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColors.secBrown
              ),
              borderRadius: BorderRadius.circular(360.0)
            ),
            child: SvgPicture.asset(
              "assets/icons/design.svg",
              height: 48.0,
              width: 48.0,
            ),
          ),
          SizedBox(
            width: 240.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Figma (components & design)",
                  style: TextStyle(
                    color: AppColors.secBrown,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),

                SizedBox(height: 8.0,),

                Row(
                  children: [
                    SvgPicture.asset("assets/icons/time.svg"),
                    SizedBox(width: 16.0,),
                    Text(
                      "12:00 pm",
                      style: TextStyle(
                        color: AppColors.secBrown
                      ),
                    )
                  ],
                ),

                SizedBox(height: 4.0,),

                Row(
                  children: [
                    SvgPicture.asset("assets/icons/duration.svg"),
                    SizedBox(width: 16.0,),
                    Text(
                      "30 minutes",
                      style: TextStyle(
                        color: AppColors.secBrown
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}