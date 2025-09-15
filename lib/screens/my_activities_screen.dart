import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/componenets/activity_component.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/providers/activity_provider.dart';
import 'package:project_ghoole/styles/app_colors.dart';
import 'package:provider/provider.dart';

class MyActivitiesScreen extends StatefulWidget {
  const MyActivitiesScreen({super.key});

  @override
  State<MyActivitiesScreen> createState() => _MyActivitiesScreenState();
}

class _MyActivitiesScreenState extends State<MyActivitiesScreen> {
  bool isSelectModeOn = false;

  String selectMode = "";

  bool isAllSelected = false;

  List<int> selectedIndicies = [];

  List<Activity> localReorderedList = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(
      () {
        final provider = Provider.of<ActivityProvider>(context, listen: false);
        provider.loadActivities();
        
        if (localReorderedList.isEmpty) {
          localReorderedList = List<Activity>.from(provider.activities);
        }
      }
    );
  }

  void resetValues () {
    setState(() {
      selectMode = '';
      selectedIndicies = [];
      isSelectModeOn = false;
      isAllSelected = false;
    });
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

        final activities = provider.activities;

        return Scaffold(
          backgroundColor: AppColors.secWhite,
          appBar: appBar(
            hasOptions: true, 
            context: context, 
            isOptionOpen: isSelectModeOn,
            openOptionAction: () {
              resetValues();
            },
            options: [
              Text(
                "Rearrange Activities",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
              Text(
                "Add Activity",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
              Text(
                "Mark Completed Activity",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
              Text(
                "Remove Activity",
                style: TextStyle(
                  color: AppColors.priBrown,
                  fontSize: 14.0
                ),
              ),
            ],
            onChange: (value) {
              if (value != null) {
                int i = int.parse(value);
                if (i == 0) {
                  setState(() {
                    selectMode = "reorder";
                    isSelectModeOn = true;
                  });
                } else if (i == 1) {
                  Navigator.pushNamed(context, "/new");
                } else if (i == 2) {
                  setState(() {
                    isSelectModeOn = true;
                    selectMode = "mark";
                  });
                } else {
                  setState(() {
                    isSelectModeOn = true;
                    selectMode = "delete";
                  });
                }
              }
            },
          ),
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

                    if (selectMode == "reorder")
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      itemCount: localReorderedList.length, 
                      onReorder: (oldIndex, newIndex) async{
                        setState(() {
                          if (newIndex > oldIndex) newIndex -= 1;
                          final item = localReorderedList.removeAt(oldIndex);
                          localReorderedList.insert(newIndex, item);
                        });

                        provider.setActivities(localReorderedList);
                        await provider.reorderActivities(activities: localReorderedList);
                      },
                      itemBuilder: (context, index) {
                        final activity = localReorderedList[index];
                        return Padding(
                          key:  ValueKey(activity.id),
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.drag_handle, color: AppColors.secBrown,),
                              SizedBox(width: 4.0,),
                              Container(
                                alignment: Alignment.center,
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width - 56
                                ),
                                child: activityComponent(
                                  context: context,
                                  activityId: activity.id,
                                  activityName: activity.name,
                                  activityDuration: activity.duration,
                                  activityTime: activity.time,
                                  activityDetails: activity.details,
                                  activityTag: activity.tag,
                                  isSelectMode: false,
                                  isReordertMode: true
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )

                    else
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        Activity activity = activities[index];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isSelectModeOn 
                            ? 
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedIndicies.contains(index)) {
                                    selectedIndicies.remove(index);
                                  } else {
                                    selectedIndicies.add(index);
                                  }
                                });
                              },
                              child: selectedIndicies.contains(index) ? SvgPicture.asset("assets/icons/select.svg") : SvgPicture.asset("assets/icons/unselect.svg")
                            ) 
                            : 
                            SizedBox.shrink(),

                            isSelectModeOn 
                            ? 
                            SizedBox(width: 16.0,) 
                            : 
                            SizedBox.shrink(),
                            Container(
                              alignment: Alignment.center,
                              child: activityComponent(
                                context: context,
                                activityId: activity.id,
                                activityName: activity.name,
                                activityDuration: activity.duration,
                                activityTime: activity.time,
                                activityDetails: activity.details,
                                activityTag: activity.tag,
                                isSelectMode: isSelectModeOn,
                              ),
                            )
                          ],
                        );
                      }, 
                      separatorBuilder: (context, index) => SizedBox(height: 16.0,)
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
                          if (selectMode == "reorder")
                          SizedBox.shrink()
                          else
                          isAllSelected
                          ?
                          txtBtnComponent(
                            onTap: () {
                              setState(() {
                                isAllSelected = false;
                                selectedIndicies.clear();
                              });
                            },
                            title: "Deselect All"
                          )
                          :
                          txtBtnComponent(onTap: () {
                            setState(() {
                              List<int> newIndicies = List.generate(activities.length, (index) => index).where((i) => !selectedIndicies.contains(i)).toList();
                              selectedIndicies.addAll(newIndicies);
                              isAllSelected = true;
                            });
                          }, title: "Select All"),

                          if (selectMode == "reorder")
                          btnComponent(onPressed: () {
                            resetValues();

                            resetValues();
                          }, title: "Done") 

                          else
                          selectMode == "mark" 
                          ? 
                          btnComponent(onPressed: () async {
                            final updatePayload = selectedIndicies.map((index) => ActivityRecordUpdatePayload(activityId: activities[index].id, update: DateTime.now().toIso8601String())).toList();
                            await provider.updateActivitiesRecord(updates: updatePayload);

                            resetValues();
                          }, title: "Mark As Completed") 
                          : 
                          btnComponent(onPressed: () async {
                            List<String> activityIds = selectedIndicies.map((index) => activities[index].id).toList();
                            await provider.removeActivies(activityIds: activityIds);

                            resetValues();
                          }, title: "Delete Selected")
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
      },
    );
  }
}