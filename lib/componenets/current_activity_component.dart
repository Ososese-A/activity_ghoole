import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget currentActivityComponent () {
  return GestureDetector(
    child: Container(
      padding: EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: AppColors.priBrown,
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Activity",
            style: TextStyle(
              color: AppColors.priWhite,
              fontSize: 16.0,
              fontWeight: FontWeight.w600
            ),
          ),

          SizedBox(height: 16.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColors.priWhite
                  ),
                  borderRadius: BorderRadius.circular(360.0),
                ),
                child: SvgPicture.asset(
                  "assets/icons/design_w.svg",
                  height: 64.0,
                  width: 64.0,
                ),
              ),
              SizedBox(
                width: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Figma (components & re-design)",
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.priWhite,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                    SizedBox(height: 8.0,),

                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/time_w.svg"),
                        SizedBox(width: 16.0,),
                        Text(
                          "12:00 pm",
                          style: TextStyle(
                            color: AppColors.priWhite
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 8.0,),

                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/duration_w.svg"),
                        SizedBox(width: 16.0,),
                        Text(
                          "30 minutes",
                          style: TextStyle(
                            color: AppColors.priWhite
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 8.0,),
                    
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/ongoing_w.svg"),
                        SizedBox(width: 16.0,),
                        Text(
                          "ongoing",
                          style: TextStyle(
                            color: AppColors.priWhite
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}