import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/componenets/activity_component.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/current_activity_component.dart';
import 'package:project_ghoole/componenets/field_component.dart';
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
          _moreOptions()
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
    
              btnComponent(
                onPressed: () {},
                title: "Add Activity"
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

  Widget _moreOptions () {
    return GestureDetector(
      child: SvgPicture.asset("assets/icons/more.svg"),
      onTapDown: (TapDownDetails details) {
        showMenu(
          elevation: 0.0,
          color: AppColors.priWhite,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.0,
              color: AppColors.priBrown
            ),
            borderRadius: BorderRadius.circular(8.0)
          ),
          context: context, 
          position: RelativeRect.fromLTRB(
            details.globalPosition.dx,
            details.globalPosition.dy,
            details.globalPosition.dx,
            details.globalPosition.dy
          ),
          items: [
            PopupMenuItem(
              value: 0,
              child: Text(
                "Add Activity",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
            ),
            PopupMenuItem(
              value: 1,
              child: Text(
                "Set Work Time",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                "Use Work Times",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
            ),
          ]
        ).then((selected) {
          if (selected != null) {
            if (selected == 0) {
            } else if (selected == 1) {
              _showWorkTimeDialog();
            } else {
            }
          }
        });
      }
    );
  }

  void _showWorkTimeDialog () {
    final TextEditingController startController = TextEditingController();
    final TextEditingController endController = TextEditingController();

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.priWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.0)
          ),
          content: Container(
            width: 400.0,
            height: 232.0,
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
            child: Column(
              children: [
                nameFieldComponent(
                  controller: startController,
                  title: "Start Work Time"
                ),
                SizedBox(height: 32.0,),
                nameFieldComponent(
                  controller: endController,
                  title: "End Work Time"
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                txtBtnComponent(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: "Cancel"
                ),
                
                btnComponent(
                  onPressed: () {
                    String start = startController.text;
                    String end = endController.text;

                    debugPrint("This is the start $start and this is the end $end");
                    Navigator.pop(context);
                  },
                  title: "Done"
                ),
              ],
            )
          ],
        );
      }
    );
  }
}