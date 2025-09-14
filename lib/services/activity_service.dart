import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_ghoole/models/activity.dart';

final box = Hive.box<Activity>('activities');

class ActivityService {
  Future<List<Activity>> fetchActivities() async {
    List<Activity> activities = [];

    activities = box.values.toList();

    return activities;
  }

  Future<Activity?> fetchActivity({required String activityId}) async {
    try {
      Activity activity = box.values.firstWhere(
        (a) => a.id == activityId,
      );

      return activity;
    } catch (e) {
      return null;
    }
  }

  Future<bool> storeActivity({required Activity activity}) async {
    bool success = false;

    try {
      await box.add(activity);

      success = true;

      return success;
    } catch (e) {
      return success;
    }

  }

  Future<bool> updateActivity({required String activityId, String? activityName, String? activityDuration, String? activityTime, String? activityDetails}) async {
    bool success = false;

    try {
      final activity = await fetchActivity(activityId: activityId);

      if (activity != null) {
        if (activityName != null) activity.name = activityName;
        if (activityDuration != null) activity.duration = activityDuration;
        if (activityTime != null) activity.time = activityTime;
        if (activityDetails != null) activity.details = activityDetails;

        await activity.save();

        success = true;
      }

      return success;
    } catch (e) {
      return success;
    }
  }

  Future<bool> deleteActivity({required String activityId}) async {
    bool success = false;

    try {
      Activity activity = box.values.firstWhere(
        (a) => a.id == activityId,
      );

      await activity.delete();

      success = true;

      return success;
    } catch (e) {
      return success;
    }
  }
}