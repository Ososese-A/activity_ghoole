import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/field_component.dart';
import 'package:project_ghoole/componenets/test_calendar_component.dart';
import 'package:project_ghoole/styles/app_colors.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final bool areThereOptions;

  const ActivityDetailsScreen({
    super.key,
    this.areThereOptions = true
  });

  @override
  State<ActivityDetailsScreen> createState() => _ActivityDetailsScreenState();
}

class _ActivityDetailsScreenState extends State<ActivityDetailsScreen> {
  final List<DateTime> months = [
    DateTime(2025, 9),
    DateTime(2025, 8),
    DateTime(2025, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secWhite,
      appBar: appBar(
        hasOptions: widget.areThereOptions, 
        context: context, 
        options: [
          Text(
            "Edit Activity",
            style: TextStyle(
              color: AppColors.priBrown,
              fontSize: 14.0
            ),
          ),
        ],
        onChange: (value) {
          if (value != null) {
            _showEditDialog();
          }
        },
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 14.0, vertical: 14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(360.0),
                        border: Border.all(
                          width: 2,
                          color:  AppColors.secBrown
                        )
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/design.svg",
                        height: 40.0,
                        width: 40.0,
                      ),
                    ),

                    SizedBox(
                      width: 16.0,
                    ),

                    SizedBox(
                      width: 260.0,
                      child: Text(
                        "Figma (components & re-design)",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.secBrown,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 16.0,),

                if (!widget.areThereOptions)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      altBtnComponent(
                        onPressed: () {}, 
                        title: "Ongoing", 
                        icon: "assets/icons/ongoing.svg"
                      ),

                      altBtnComponent(
                        onPressed: () {
                          DateTime newCompletedTask = DateTime.now();
                          String stringDate = newCompletedTask.toIso8601String().split("T").first;

                          debugPrint(stringDate);
                        }, 
                        title: "Completed", 
                        icon: "assets/icons/done.svg"
                      ),
                    ],
                  )
                else 
                  SizedBox.shrink()
              ],
            ),
          ),

          SizedBox(height: 16.0,),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.secBrown,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0)
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Activity Details:",
                              style: TextStyle(
                                color: AppColors.priWhite,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0
                              ),
                            ),
                    
                            // SizedBox(height: 2.0,),
                    
                            Text(
                              "This is basically me re-designing the screens of different apps in an attempt to create a component library fo both Figma and flutter from them.",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.priWhite,
                              ),
                            ),
                          ],
                        ),
              
                        SizedBox(height: 16.0,),
              
                        Column(
                          children: [
                            // calendarComponent(months: months)

                            calendarBuilder()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showEditDialog () {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController detailController = TextEditingController();
    final TextEditingController durationController = TextEditingController();
    final TextEditingController hourController = TextEditingController();

    String durationUnit = 'minutes';
    final List<String> durationUnits = ['minutes', 'hours'];

    final List<String> hourOptions = [
      '06:00', '08:00', '10:00', '12:00', '14:00', '16:00', '18:00', '20:00'
    ];

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(8.0)
          ),
          backgroundColor: AppColors.priWhite,
          content: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
            width: 400,
            height: 440,
            child: Column(
              children: [
                nameFieldComponent(
                  controller: nameController
                ),
    
                const SizedBox(height: 16,),
    
                durationFieldComponent(
                  controller: durationController, 
                  unit: durationUnit, 
                  units: durationUnits, 
                  onChanged: (value) {
                    setState(() {
                      durationUnit = value!;
                    });
                  }
                ),
                
                const SizedBox(height: 16,),
    
                //editable dropdown 
                timeFieldComponent(
                  controller: hourController, 
                  options: hourOptions, 
                  onSelected: (value) {
                    setState(() {
                      hourController.text = value;
                    });
                  }
                ),
              
                SizedBox(height: 16,),
    
                detailsFieldComponent(
                  controller: detailController
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
                    String activity = nameController.text;
                    String duration = durationController.text;
                    String time = hourController.text;
                    String details = detailController.text;

                    debugPrint("This is the activity: $activity, this is the duration $duration $durationUnit, this is the time $time");
                    debugPrint("This is the details: $details");

                    Navigator.pop(context);
                  }, 
                  title: "Done"
                )
              ],
            )
          ],
        );
      }
    );
  }
}