import 'package:flutter/material.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/services/activity_service.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityService _service = ActivityService();

  List<Activity> _activities = [];
  Activity? _activity;
  bool? _wasSuccessful;
  bool _isLoading = false;

  List<Activity> get activities => _activities;
  Activity? get activity => _activity;
  bool? get wasSuccessful => _wasSuccessful;
  bool get isLoading => _isLoading;

  Future<void> loadActivities() async {
    _isLoading = true;
    notifyListeners();

    _activities = await _service.fetchActivities();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadActivity ({required String activityId}) async {
    _isLoading = true;
    notifyListeners();

    _activity = await _service.fetchActivity(activityId: activityId);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addActivity ({required Activity activity}) async {
    _isLoading = true;
    notifyListeners();

    _wasSuccessful = await _service.storeActivity(activity: activity);

    await loadActivities();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateActivity ({
    required String activityId, 
    required String? activityName, 
    required String? activityDuration, 
    required String? activityTime, 
    required String? activityDetails
    }) async {
    _isLoading = true;
    notifyListeners();

    _wasSuccessful = await _service.updateActivity(
      activityId: activityId,
      activityDetails: activityDetails,
      activityDuration: activityDuration,
      activityName: activityName,
      activityTime: activityTime
    );

    await loadActivities();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> removeActivity ({required String activityId}) async {
    _isLoading = true;
    notifyListeners();

    _wasSuccessful = await _service.deleteActivity(activityId: activityId);

    await loadActivities();

    _isLoading = false;
    notifyListeners();
  }
}