import 'package:dadoufit/src/domains/doinsport/slot.dart';

class Activity {
  final String id;
  final String name;
  final List<Slot> slots;

  const Activity({required this.id, required this.name, required this.slots});

  factory Activity.fromJson(Map<String, dynamic> json) {
    var rawSlots = json['slots'] as List;
    List<Slot> slots = rawSlots.map((item) => Slot.fromJson(item)).toList();

    return Activity(id: json['id'], name: json['name'], slots: slots);
  }
}
