import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/styles/app_colors.dart';

Widget currentActivityComponent ({required Activity activity, required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/details', arguments: {
        'id': activity.id,
        'options': false
      });
    },
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
                constraints: BoxConstraints(
                  maxHeight: 104.0,
                  maxWidth: 104.0
                ),
                padding: EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: AppColors.priWhite
                  ),
                  borderRadius: BorderRadius.circular(360.0),
                ),
                child: SvgPicture.asset(
                  "assets/icons/${activity.tag}_w.svg",
                  height: 64.0,
                  width: 64.0,
                ),
              ),

              SizedBox(width: 24.0,),

              SizedBox(
                width: 160.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.name,
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
                          activity.time,
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
                          activity.duration,
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