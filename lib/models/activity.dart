
import 'package:hive/hive.dart';

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

  Activity({
    required this.id,
    required this.name,
    required this.duration,
    required this.time,
    required this.details,
    required this.tag,
  });
}