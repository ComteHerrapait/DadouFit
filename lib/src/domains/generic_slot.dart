import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:intl/intl.dart';

class GenericSlot {
  final DateTime startTime;
  final EnumClub club;
  final EnumActivity activity;
  final List<SlotPlayground> playgrounds;

  GenericSlot({
    required this.startTime,
    required this.club,
    required this.activity,
    required this.playgrounds,
  });

  String get date => DateFormat('E d H:m').format(startTime);
  String get time => DateFormat('H:m').format(startTime);
  String get activityName => activity.name;
  String get clubName => club.name;
  List<SlotPlayground> get availablePlaygrounds =>
      playgrounds.where((p) => p.bookable).toList();
  int get availablePlaygroundCount => availablePlaygrounds.length;
  bool get isAnyBookable => availablePlaygroundCount > 0;
  int get playgroundCount => playgrounds.length;
}

class SlotPlayground {
  final bool bookable;
  final Duration duration;
  final String playgroundName;

  SlotPlayground({
    required this.bookable,
    required this.duration,
    required this.playgroundName,
  });
}
