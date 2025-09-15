import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/field_component.dart';
import 'package:project_ghoole/componenets/test_calendar_component.dart';
import 'package:project_ghoole/providers/activity_provider.dart';
import 'package:project_ghoole/styles/app_colors.dart';
import 'package:provider/provider.dart';

class ActivityDetailsScreen extends StatefulWidget {
  final bool areThereOptions;
  final String activityId;

  const ActivityDetailsScreen({
    super.key,
    this.areThereOptions = true,
    required this.activityId
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
  void initState() {
    super.initState();

    Future.microtask(() {
        Provider.of<ActivityProvider>(
          context, 
          listen: false).loadActivity(activityId: widget.activityId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, provider, _) {
        if (provider.activity == null || provider.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.secWhite,
            body: Center(child: CircularProgressIndicator(),),
          );
        }

        final activity = provider.activity!;
        final lastUpdated = DateTime.parse(activity.updated);

        final shouldShowOptions = widget.areThereOptions && lastUpdated.hour != DateTime.now().hour;

        return Scaffold(
          backgroundColor: AppColors.secWhite,
          appBar: appBar(
            hasOptions: shouldShowOptions, 
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
                _showEditDialog(
                  activityId: activity.id,
                  activityName: activity.name,
                  activityDuration: activity.duration,
                  activityTime: activity.time,
                  activityDetails: activity.details
                );
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
                            "assets/icons/${activity.tag}.svg",
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),

                        SizedBox(
                          width: 16.0,
                        ),

                        SizedBox(
                          width: 260.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activity.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.secBrown,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w500
                                ),
                              ),

                              SizedBox(height: 16.0,),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/time.svg"),
                                      SizedBox(width: 16.0,),
                                      Text(
                                        activity.time,
                                        style: TextStyle(
                                          color: AppColors.secBrown
                                        ),
                                      )
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset("assets/icons/duration.svg"),
                                      SizedBox(width: 16.0,),
                                      Text(
                                        activity.duration,
                                        style: TextStyle(
                                          color: AppColors.secBrown
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 40.0,),

                    if (!widget.areThereOptions)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          altBtnComponent(
                            onPressed: () async {
                              await provider.markActivityAsIncomplete(activityId: activity.id);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Activity marked as Ongoing")),
                                );
                            }, 
                            title: "Ongoing", 
                            icon: "assets/icons/ongoing.svg"
                          ),

                          altBtnComponent(
                            onPressed: () async {
                              DateTime newCompletedTask = DateTime.now();
                              String dateCompleted = newCompletedTask.toIso8601String().split("T").first;

                              await provider.updateActivityRecord(activityId: activity.id, activityUpdate: dateCompleted);

                              if (provider.wasSuccessful!) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Activity marked as completed")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to update activity")),
                                );
                              }
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

              SizedBox(height: 40.0,),

              Expanded(
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
                        
                                Text(
                                  activity.details,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.priWhite,
                                  ),
                                ),
                              ],
                            ),
                  
                            SizedBox(height: 16.0,),

                            calendarBuilder(
                                startDate: activity.added,
                                completedRecords: activity.activityRecord
                            ),
                          ],
                        ),
                      ),
                    ),
              )
            ],
          ),
        );
      }
    );
  }

  void _showEditDialog ({
      required String activityId,
      required String activityName, 
      required String activityDuration,
      required String activityTime,
      required String activityDetails,
    }) {
    final TextEditingController nameController = TextEditingController();
    nameController.text = activityName;
    final TextEditingController detailController = TextEditingController();
    detailController.text = activityDetails;
    final TextEditingController durationController = TextEditingController();
    durationController.text = activityDuration.length > 2 ? activityDuration.split(" ").first : activityDuration;
    final TextEditingController hourController = TextEditingController();
    hourController.text = activityTime;

    String durationUnit = activityDuration.length > 2 ? activityDuration.split(" ")[1] : "hours";
    final List<String> durationUnits = ['minutes', 'hours'];

    final List<String> hourOptions = [
    '00:00', 
    '01:00', 
    '02:00', 
    '03:00', 
    '04:00', 
    '05:00', 
    '06:00', 
    '07:00', 
    '08:00', 
    '09:00', 
    '10:00', 
    '11:00', 
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
    '19:00',
    '20:00',
    '21:00',
    '22:00',
    '23:00',
  ];

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)
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
                  onPressed: () async {
                    String activity = nameController.text;
                    String duration = "${durationController.text} $durationUnit";
                    String time = hourController.text;
                    String details = detailController.text;

                    debugPrint("This is the activity: $activity, this is the duration $duration $durationUnit, this is the time $time");
                    debugPrint("This is the details: $details");

                    await Provider.of<ActivityProvider>(context, listen: false).updateActivity(
                      activityId: activityId, 
                      activityName: activity, 
                      activityDuration: duration, 
                      activityTime: time, 
                      activityDetails: details,
                      updated: DateTime.now().toIso8601String().split("T").first
                    );

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