import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/componenets/activity_component.dart';
import 'package:project_ghoole/componenets/current_activity_component.dart';
import 'package:project_ghoole/styles/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isListEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secWhite,
      appBar: AppBar(
        backgroundColor: AppColors.secWhite,
        leadingWidth: 120.0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Text(
            "GHOOLE",
            softWrap: false,
            style: TextStyle(
              color: AppColors.secBrown,
              fontSize: 24.0,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 14.0),
        actions: [
          SvgPicture.asset("assets/icons/more.svg")
        ],
      ),
      body: 
      isListEmpty
      ?
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.transparent
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/nill.svg"),
    
              SizedBox(height: 32.0,),
    
              Text(
                "No Activity Found",
                style: TextStyle(
                  fontSize: 24.0,
                  color: AppColors.secBrown,
                  fontWeight: FontWeight.w600
                ),
              ),
    
              SizedBox(height: 16.0,),
    
              Text(
                "Add in a new activity and let Ghoole do it’s work",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secBrown
                ),
              ),
    
              SizedBox(height: 32.0,),
    
              Container(
                padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  color: AppColors.priBrown,
                  borderRadius: BorderRadius.circular(4.0)
                ),
                child: Text(
                  "Add Activity",
                  style: TextStyle(
                    color: AppColors.priWhite,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          ),
      )
      :
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/calendar.svg"),
                SizedBox(width: 16.0,),
                Text(
                  "Monday 24th July 2025",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),

            SizedBox(height: 24.0,),
            
            currentActivityComponent(),

            SizedBox(height: 40.0,),

            _activityQueue(),

            SizedBox(height: 32.0,),

            _completedActivity()
          ],
        ),
      )
    );
  }

  Widget _activityQueue () {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/queue.svg"),

                SizedBox(width: 16.0,),

                Text(
                  "Activity Queue",
                  style: TextStyle(
                    color: AppColors.secBrown,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),

            SvgPicture.asset("assets/icons/down.svg")
          ],
        ),

        SizedBox(height: 24.0,),

        activityComponent()
      ],
    );
  }

  Widget _completedActivity () {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/icons/completed.svg"),

                SizedBox(width: 16.0,),

                Text(
                  "Completed Activities",
                  style: TextStyle(
                    color: AppColors.secBrown,
                    fontWeight: FontWeight.w500
                  ),
                )
              ],
            ),

            SvgPicture.asset("assets/icons/down.svg")
          ],
        ),

        SizedBox(height: 24.0,),

        activityComponent()
      ],
    );
  }
}