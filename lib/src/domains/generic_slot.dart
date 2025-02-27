import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenericSlot {
  final bool bookable;
  final Duration duration;
  final DateTime startTime;
  final String playgroundName;
  final String clubName;
  final String activityName;

  // TODO : add more informations (if needed)

  GenericSlot({
    required this.bookable,
    required this.duration,
    required this.startTime,
    required this.playgroundName,
    required this.clubName,
    required this.activityName,
  });

  DateTimeRange get time {
    return DateTimeRange(start: startTime, end: startTime.add(duration));
  }

  @override
  String toString() {
    return "${DateFormat('E d H:m').format(startTime)} (${duration.inMinutes} min)";
  }
}
