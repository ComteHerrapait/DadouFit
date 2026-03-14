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
    final rawActivities = json['activities'];

    // sometimes the doinsport API responds with a map instead of a list
    final activitiesList = rawActivities is Map
        ? rawActivities.values.toList()
        : rawActivities as List;

    final mappedActivities =
        activitiesList.map((item) => Activity.fromJson(item)).toList();

    return ClubPlayground(
      id: json['id'],
      name: json['name'],
      indoor: json['indoor'],
      activities: mappedActivities,
      openingTime: json['timetables']['startAt'],
      closingTime: json['timetables']['endAt'],
    );
  }
}
