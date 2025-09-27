import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_ghoole/componenets/activity_component.dart';
import 'package:project_ghoole/componenets/app_bar.dart';
import 'package:project_ghoole/componenets/btn_component.dart';
import 'package:project_ghoole/componenets/empty_state_component.dart';
import 'package:project_ghoole/componenets/loading_component.dart';
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
            body: loadingComponent(),
          );
        }

        final activities = provider.activities;
        final isListEmpty = provider.activities.isEmpty;

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
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
            child: 
            isListEmpty 
            ?
            _empty()
            :
            Stack(
              children: [
                /// 👇 Replace Column with CustomScrollView
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 120.0),
                        child: Text(
                          "My Activities",
                          style: TextStyle(
                            color: AppColors.secBrown,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    if (selectMode == "reorder")
                      SliverReorderableList(
                        itemCount: localReorderedList.length,
                        onReorder: (oldIndex, newIndex) async {
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
                            key: ValueKey(activity.id),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.drag_handle, color: AppColors.secBrown),
                                SizedBox(width: 4.0),
                                Container(
                                  alignment: Alignment.center,
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width - 56,
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
                                    isReordertMode: true,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final activity = activities[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                children: [
                                  if (isSelectModeOn)
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
                                      child: selectedIndicies.contains(index)
                                          ? SvgPicture.asset("assets/icons/select.svg")
                                          : SvgPicture.asset("assets/icons/unselect.svg"),
                                    ),
                                  if (isSelectModeOn) SizedBox(width: 16.0),
                                  Expanded(
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
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: activities.length,
                        ),
                      ),
                  ],
                ),

                /// 👇 Bottom action bar stays fixed
                if (isSelectModeOn)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.secWhite,
                        border: Border.all(
                          width: 2.0,
                          color: AppColors.secWhite
                        )
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (selectMode != "reorder")
                            isAllSelected
                                ? txtBtnComponent(
                                    onTap: () {
                                      setState(() {
                                        isAllSelected = false;
                                        selectedIndicies.clear();
                                      });
                                    },
                                    title: "Deselect All",
                                  )
                                : txtBtnComponent(
                                    onTap: () {
                                      setState(() {
                                        List<int> newIndicies = List.generate(activities.length, (index) => index)
                                            .where((i) => !selectedIndicies.contains(i))
                                            .toList();
                                        selectedIndicies.addAll(newIndicies);
                                        isAllSelected = true;
                                      });
                                    },
                                    title: "Select All",
                                  ),
                          btnComponent(
                            onPressed: () async {
                              if (selectMode == "reorder") {
                                resetValues();
                              } else if (selectMode == "mark") {
                                final updatePayload = selectedIndicies
                                    .map((index) => ActivityRecordUpdatePayload(
                                        activityId: activities[index].id,
                                        update: DateTime.now().toIso8601String()))
                                    .toList();
                                await provider.updateActivitiesRecord(updates: updatePayload);
                                resetValues();
                              } else {
                                final activityIds = selectedIndicies.map((index) => activities[index].id).toList();
                                await provider.removeActivies(activityIds: activityIds);
                                resetValues();
                              }
                            },
                            title: selectMode == "reorder"
                                ? "Done"
                                : selectMode == "mark"
                                    ? "Mark As Completed"
                                    : "Delete Selected",
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _empty () {
    return Column (
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "My Activities",
              style: TextStyle(
                color: AppColors.secBrown,
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
              ),
            ),
        ),

        emptyState(context: context),
      ],
    );
  }
}