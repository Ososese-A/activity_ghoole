import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project_ghoole/componenets/activity_component.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/current_activity_component.dart';
import 'package:project_ghoole/componenets/field_component.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/providers/activity_provider.dart';
import 'package:project_ghoole/styles/app_colors.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState () {
    super.initState();

    Future.microtask(() {
      Provider.of<ActivityProvider>(context, listen: false).loadActivities();
      Provider.of<ActivityProvider>(context, listen: false).getWorkTime();
    });
  }

  int getHourFromActivity ({required String activityHour}) {
    // debugPrint("This is the activity hour pre parsing $activityHour");
    
    if (activityHour.trim().isNotEmpty) {
      String hour = activityHour.split(":").first;
      // debugPrint(hour);
      return int.parse(hour);
    } else {
      return -1;
    }
  }

  bool queueToggle = false;
  bool completedToggle = true;

  String getDisplayDate () {
    DateTime todaysDate = DateTime.now();

    final day = todaysDate.day;
    String suffix = "";

    if (day >= 11 && day <= 13) suffix = 'th';

    switch (day % 10) {
      case 1: suffix = 'st';
      case 2: suffix = 'nd';
      case 3: suffix = 'rd';
      default: suffix = 'th';
    }

    final weekday = DateFormat('EEEE').format(todaysDate);
    final month = DateFormat('MMMM').format(todaysDate);
    final year = todaysDate.year;

    return "$weekday $day$suffix $month $year";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Scaffold(
            backgroundColor: AppColors.secWhite,
            body: Center(child: CircularProgressIndicator(),),
          );
        }

        final isListEmpty = provider.activities.isEmpty;

        final activities = provider.activities;

        final futureActivities = activities.where((activity) {
          final int h = getHourFromActivity(activityHour: activity.time);
          // debugPrint("This is the activity hour $h and the current hour ${DateTime.now().hour}");
          return h > DateTime.now().hour;
        }).toList();

        final currentActivity = activities.firstWhere(
          (activity) {
            final int h = getHourFromActivity(activityHour: activity.time);
            // debugPrint("This is the activity hour $h and the current hour ${DateTime.now().hour}");
            return h == DateTime.now().hour;
          },
          orElse: () => Activity(
            id: "none", 
            name: "none", 
            duration: "", 
            time: "", 
            details: "", 
            tag: "",
            added: "",
            updated: ""
          ),
        );

        final completedActivities = activities.where((activity) {
          final int h = getHourFromActivity(activityHour: activity.time);
          // debugPrint("This is the activity hour $h and the current hour ${DateTime.now().hour}");
          return h < DateTime.now().hour;
        }).toList();

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
          _emptyState()
          :
          SingleChildScrollView(child: _activityState(
            future: futureActivities, 
            past: completedActivities, 
            current: currentActivity
          ))
        );
    
      }
    );
  }

  Widget _activityQueue ({required List<Activity> activities}) {

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
      
              GestureDetector(
                onTap: () {
                  setState(() {
                    queueToggle = !queueToggle;
                  });
                },
                child: queueToggle ? SvgPicture.asset("assets/icons/down.svg") : SvgPicture.asset("assets/icons/up.svg")
              )
            ],
          ),
      
          SizedBox(height: 24.0,),

          if (!queueToggle)
            activities.isEmpty
            ?
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  "You currently have no activities in your queue.",
                  style: TextStyle(
                    color: AppColors.secBrown,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
            :
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 320.0
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    Activity activity = activities[index];
              
                    return activityComponent(
                      context: context,
                      activityId: activity.id,
                      activityName: activity.name,
                      activityDuration: activity.duration,
                      activityTime: activity.time,
                      activityDetails: activity.details,
                      activityTag: activity.tag
                    );
                  }, 
                  separatorBuilder:(context, index) {
                    return SizedBox(height: 24.0,);
                  },
                ),
            ),
        ],
      );
  }

  Widget _completedActivity ({required List<Activity> activities}) {
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

            GestureDetector(
              onTap: () {
                setState(() {
                  completedToggle = !completedToggle;
                });
              },
              child: completedToggle ? SvgPicture.asset("assets/icons/up.svg") : SvgPicture.asset("assets/icons/down.svg"),
            )
          ],
        ),

        SizedBox(height: 24.0,),

        if (completedToggle)

          activities.isEmpty
            ?
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  "You currently have no completed activities.",
                  style: TextStyle(
                    color: AppColors.secBrown,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
            :
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  shrinkWrap: true,
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      Activity activity = activities[index];
                
                      return activityComponent(
                        context: context,
                        activityId: activity.id,
                        activityName: activity.name,
                        activityDuration: activity.duration,
                        activityTime: activity.time,
                        activityDetails: activity.details,
                        activityTag: activity.tag
                      );
                    }, 
                    separatorBuilder:(context, index) {
                      return SizedBox(height: 24.0,);
                    },
                  ),
              ],
            ),
      ],
    );
  }

  Widget _moreOptions () {
    final provider = Provider.of<ActivityProvider>(context);
    final timeToUse = provider.useWorkTime;

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
                timeToUse ? "Use Work Time" : "Use Activity Time",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
            ),
            PopupMenuItem(
              value: 3,
              child: Text(
                "My Activities",
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
              Navigator.pushNamed(context, '/new');
            } else if (selected == 1) {
              _showWorkTimeDialog();
            } else if (selected == 2) {
              provider.setActivityTime(timeBool: !timeToUse);
            } else {
              Navigator.pushNamed(context, '/activities');
            }
          }
        });
      }
    );
  }

  void _showWorkTimeDialog () {
    final TextEditingController startController = TextEditingController();
    final TextEditingController endController = TextEditingController();

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
                timeFieldComponent(
                  controller: startController, 
                  options: hourOptions, 
                  title: "Start Work Time",
                  onSelected: (value) {
                    setState(() {
                      startController.text = value;
                    });
                  }
                ),

                SizedBox(height: 32.0,),

                timeFieldComponent(
                  controller: endController, 
                  options: hourOptions, 
                  title: "End Work Time",
                  onSelected: (value) {
                    setState(() {
                      endController.text = value;
                    });
                  }
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
                    String start = startController.text;
                    String end = endController.text;

                    final provider = Provider.of<ActivityProvider>(context, listen: false);
                    await provider.setWorkTime(endTime: end, startTime: start);
                    final wasSuccessful = provider.wasSuccessful!;

                    if (wasSuccessful) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Work time config successful")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Work time config unsuccessful")),
                      );
                    }

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

  Widget _activityState ({required List<Activity> future, required List<Activity> past, required Activity current}) {
    final provider = Provider.of<ActivityProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset("assets/icons/calendar.svg"),
              SizedBox(width: 16.0,),
              Text(
                "${getDisplayDate()} ${provider.startTime}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500
                ),
              )
            ],
          ),

          SizedBox(height: 24.0,),
          
          if (current.name != "none")
            currentActivityComponent(activity: current, context: context)
          else
            SizedBox.shrink(),

          SizedBox(height: 40.0,),

          _activityQueue(activities: future),

          SizedBox(height: 32.0,),

          _completedActivity(activities: past)
        ],
      ),
    );
  }

  Widget _emptyState () {
    return Container(
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
              onPressed: () {
                Navigator.pushNamed(context, '/new');
              },
              title: "Add Activity"
            )
          ],
        ),
    );
  }
}