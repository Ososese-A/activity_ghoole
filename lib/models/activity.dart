
import 'package:hive/hive.dart';

part 'activity.g.dart';

@HiveType(typeId: 0)
class Activity extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;

  @HiveField(2)
  String duration;

  @HiveField(3)
  String time;

  @HiveField(4)
  String details;

  @HiveField(5)
  String tag;

  @HiveField(6)
  String added;

  @HiveField(7)
  String updated;

  @HiveField(8)
  List<String>? activityRecord;

  Activity({
    required this.id,
    required this.name,
    required this.duration,
    required this.time,
    required this.details,
    required this.tag,
    required this.added,
    required this.updated,
    this.activityRecord
  });
}