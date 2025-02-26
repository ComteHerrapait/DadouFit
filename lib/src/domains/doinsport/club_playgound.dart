import 'package:dadoufit/src/domains/doinsport/activity.dart';

class ClubPlayground {
  final String id;
  final String name;
  final bool indoor;
  final List<Activity> activities;
  final String openingTime;
  final String closingTime;

  const ClubPlayground({
    required this.id,
    required this.name,
    required this.indoor,
    required this.activities,
    required this.openingTime,
    required this.closingTime,
  });

  factory ClubPlayground.fromJson(Map<String, dynamic> json) {
    final rawActivities = json['activities'] as List;
    List<Activity> activities =
        rawActivities.map((item) => Activity.fromJson(item)).toList();

    return ClubPlayground(
      id: json['id'],
      name: json['name'],
      indoor: json['indoor'],
      activities: activities,
      openingTime: json['timetables']['startAt'],
      closingTime: json['timetables']['endAt'],
    );
  }
}
