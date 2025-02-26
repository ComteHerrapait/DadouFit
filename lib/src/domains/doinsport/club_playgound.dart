import 'package:dadoufit/src/domains/doinsport/activity.dart';

class ClubPlaygound {
  final String id;
  final String name;
  final bool indoor;
  final List<Activity> activities;

  const ClubPlaygound({
    required this.id,
    required this.name,
    required this.indoor,
    required this.activities,
  });

  factory ClubPlaygound.fromJson(Map<String, dynamic> json) {
    final rawActivities = json['activities'] as List;
    List<Activity> activities =
        rawActivities.map((item) => Activity.fromJson(item)).toList();

    return ClubPlaygound(
      id: json['id'],
      name: json['name'],
      indoor: json['indoor'],
      activities: activities,
    );
  }
}
