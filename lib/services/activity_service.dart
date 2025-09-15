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

  Future<bool> updateActivity({required String activityId, String? activityName, String? activityDuration, String? activityTime, String? activityDetails, String? updated}) async {
    bool success = false;

    try {
      final activity = await fetchActivity(activityId: activityId);

      if (activity != null) {
        if (activityName != null) activity.name = activityName;
        if (activityDuration != null) activity.duration = activityDuration;
        if (activityTime != null) activity.time = activityTime;
        if (activityDetails != null) activity.details = activityDetails;
        if (updated != null) activity.updated = updated;

        await activity.save();

        success = true;
      }

      return success;
    } catch (e) {
      return success;
    }
  }

  Future<bool> updateActivities({required List<ActivityUpdatePayload> updates}) async {
    bool success = false;

    try {
      for (final payload in updates) {
        final activity = await fetchActivity(activityId: payload.activityId);

        if (activity != null) {
          if (payload.name != null) activity.name = payload.name!;
          if (payload.duration != null) activity.duration = payload.duration!;
          if (payload.time != null) activity.time = payload.time!;
          if (payload.details != null) activity.details = payload.details!;
          if (payload.updated != null) activity.updated = payload.updated!;

          await activity.save();
        }

        // else {
        //   debugPrint("Activity with ID ${payload.activityId} not found.");
        // }
      }
      success = true;
      return success;
    } catch (e) {
      success = false;
      return success;
    }
  }

  Future<bool> updateActivityRecord ({required String activityId, required String activityUpdate}) async {
    bool success = false;

    try {
      final activity = await fetchActivity(activityId: activityId);

      if (activity != null ) {
        activity.activityRecord = [...?activity.activityRecord, activityUpdate];

        await activity.save();

        success = true;
      }

      return success;
    } catch (e) {
      return success;
    }
  }

  Future<bool> updateActivitiesRecord ({required List<ActivityRecordUpdatePayload> updates }) async {
    bool success = false;

    try {
      for (final payload in updates) {
        final activity = await fetchActivity(activityId: payload.activityId);

        if (activity != null ) {
          activity.activityRecord = [...?activity.activityRecord, payload.update];

          await activity.save();
        }
        // else {
        //   debugPrint("Activity with ID ${payload.activityId} not found.");
        //   success = false;
        // }
      }

      success = true;
      return success;
    } catch (e) {
      return success;
    }
  }

  Future<bool> reaggangeList ({required List<Activity> reorderedList}) async {
    bool success = false;
    try {
      await box.clear();
      for (final activity in reorderedList) {
        await storeActivity(activity: activity);
      }

      success = true;
      return success;
    } catch (e) {
      success = false;
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

  Future<bool> deleteActivities ({required List<String> activityIds}) async {
   bool success = true;

   try {
    for (final id in activityIds) {
      final activity = box.values.firstWhere(
        (a) => a.id == id,
        orElse: () => Activity(
          id: '', 
          name: '', 
          duration: '', 
          time: '', 
          details: '', 
          tag: '', 
          added: '', 
          updated: ''
        ),
      );

      if (activity.id.isNotEmpty) {
        await activity.delete();
      } 
      // else {
      //   debugPrint("Activity with ID $id not found");
      // }
    }
   } catch (e) {
    success = false;
   }

   return success;
  }
}