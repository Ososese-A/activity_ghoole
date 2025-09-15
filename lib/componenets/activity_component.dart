import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget activityComponent ({
    required BuildContext context,
    required String activityId, 
    required String activityName, 
    required String activityDuration, 
    required String activityTime, 
    required String activityTag, 
    required String activityDetails,
    bool isSelectMode = false, 
    bool isReordertMode = false, 
  }) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/details', arguments: {
        'id': activityId,
        'options': true
      });
    },
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 40.0,
                maxWidth: 40.0
              ),
              child: SvgPicture.asset(
                activityTag != "" ? "assets/icons/$activityTag.svg" : "assets/icons/code.svg",
                height: 48.0,
                width: 48.0,
              ),
            ),
          ),

          // isSelectMode ? SizedBox(width: 16.0,) : SizedBox.shrink(),
          SizedBox(width: 16.0,),

          SizedBox(
            width: isSelectMode || isReordertMode ? 200 : 240.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activityName,
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
                      activityTime,
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
                      activityDuration,
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