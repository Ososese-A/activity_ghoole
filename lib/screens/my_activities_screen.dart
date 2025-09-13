import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/componenets/activity_component.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/styles/app_colors.dart';

class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({super.key});

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
  bool isSelectModeOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secWhite,
      appBar: appBar(hasOptions: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 24.0),
                  child: Text(
                    "My Activities",
                    style: TextStyle(
                      color: AppColors.secBrown,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
            
                Row(
                  children: [
                    isSelectModeOn ? SvgPicture.asset("assets/icons/unselect.svg") : SizedBox.shrink(),
                    isSelectModeOn ? SizedBox(width: 16.0,) : SizedBox.shrink(),
                    activityComponent(
                      isSelectMode: isSelectModeOn
                    )
                  ],
                ),
                SizedBox(height: 16.0,),
                Row(
                  children: [
                    isSelectModeOn ? SvgPicture.asset("assets/icons/unselect.svg") : SizedBox.shrink(),
                    isSelectModeOn ? SizedBox(width: 16.0,) : SizedBox.shrink(),
                    activityComponent(
                      isSelectMode: isSelectModeOn
                    )
                  ],
                ),
                SizedBox(height: 16.0,),
                Row(
                  children: [
                    isSelectModeOn ? SvgPicture.asset("assets/icons/unselect.svg") : SizedBox.shrink(),
                    isSelectModeOn ? SizedBox(width: 16.0,) : SizedBox.shrink(),
                    activityComponent(
                      isSelectMode: isSelectModeOn
                    )
                  ],
                ),
                SizedBox(height: 16.0,),
                Row(
                  children: [
                    isSelectModeOn ? SvgPicture.asset("assets/icons/unselect.svg") : SizedBox.shrink(),
                    isSelectModeOn ? SizedBox(width: 16.0,) : SizedBox.shrink(),
                    activityComponent(
                      isSelectMode: isSelectModeOn
                    )
                  ],
                ),
              ],
            ),

            if (isSelectModeOn)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      txtBtnComponent(onTap: () {}, title: "Select All"),
                  
                      btnComponent(onPressed: () {}, title: "Delete Selected")
                    ],
                  ),
                ),
              )

            else 

              SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}