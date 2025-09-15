import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_ghoole/models/activity.dart';
import 'package:project_ghoole/services/activity_service.dart';

class ActivityProvider extends ChangeNotifier {
  final ActivityService _service = ActivityService();

  List<Activity> _activities = [];
  Activity? _activity;
  bool? _wasSuccessful;
  bool _isLoading = false;
  bool _useWorkTime = false;
  String? _startTime;
  String? _endTime;

  List<Activity> get activities => _activities;
  Activity? get activity => _activity;
  bool? get wasSuccessful => _wasSuccessful;
  bool get isLoading => _isLoading;
  bool get useWorkTime => _useWorkTime;
  String? get startTime => _startTime;
  String? get endTime => _endTime;

  void setActivityTime ({required bool timeBool}) {
    _useWorkTime = timeBool;
  }

  Future<void> setWorkTime ({required String startTime, required String endTime}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final box = Hive.box('work_time');

      await box.put(0, startTime);
      await box.put(1, endTime);

      _wasSuccessful = true;
    } catch (e) {
      _wasSuccessful = false;
    }

    await getWorkTime();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> getWorkTime () async {
    _isLoading = true;
    notifyListeners();

    try {
      final box = Hive.box('work_time');

      _startTime = await box.get(0, defaultValue: '09:00');
      _endTime =  await box.get(1, defaultValue: '17:00');

      _wasSuccessful = true;
    } catch (e) {
      _wasSuccessful = false;
    }

    _isLoading = false;
    notifyListeners();
  }

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
    required String activityName, 
    required String activityDuration, 
    required String activityTime, 
    required String activityDetails,
    required String updated
    }) async {
    _isLoading = true;
    notifyListeners();

    _wasSuccessful = await _service.updateActivity(
      activityId: activityId,
      activityDetails: activityDetails,
      activityDuration: activityDuration,
      activityName: activityName,
      activityTime: activityTime,
      updated: updated
    );

    await loadActivities();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateActivityRecord ({required String activityId, required String activityUpdate}) async {
    _isLoading = true;
    notifyListeners();

    _wasSuccessful = await _service.updateActivityRecord(activityId: activityId, activityUpdate: activityUpdate);

    _isLoading = false;
    notifyListeners();
  }

  Future<void> markActivityAsIncomplete ({required activityId}) async {
    _isLoading = true;
    notifyListeners();

    final activity = await _service.fetchActivity(activityId: activityId);

    if (activity != null && activity.activityRecord != null && activity.activityRecord!.isNotEmpty) {
      activity.activityRecord!.removeLast();
      await activity.save();

      _activity = activity;
      await loadActivities();
    }

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