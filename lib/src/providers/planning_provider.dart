import 'package:dadoufit/src/apis/doinsport_api.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:dadoufit/src/mappers/doinsport_mapper.dart';
import 'package:flutter/material.dart';

class PlanningProvider extends ChangeNotifier {
  EnumClub selectedClub = EnumClub.pommeraie;
  EnumActivity selectedActivity = EnumActivity.padel;
  DateTime selectedDate = DateTime.now();

  late Future<List<GenericSlot>> data;

  Future<List<GenericSlot>> getPlannings() {
    return data;
  }

  PlanningProvider() {
    updateSlots();
  }

  void selectClub(EnumClub? newClub) {
    if (newClub == null) {
      return;
    }
    selectedClub = newClub;
    updateSlots();
    notifyListeners();
  }

  void selectActivity(EnumActivity? newActivity) {
    if (newActivity == null) {
      return;
    }
    selectedActivity = newActivity;
    updateSlots();
    notifyListeners();
  }

  void selectDate(DateTime? newDateTime) {
    if (newDateTime == null) {
      return;
    }
    selectedDate = DateUtils.dateOnly(newDateTime);
    updateSlots();
    notifyListeners();
  }

  void updateSlots() async {
    data = getPlaygroundPlannings(
      selectedDate,
      selectedClub,
      selectedActivity,
    ).then(
      (value) => Future.value(
        mapToGenericSlots(value, selectedClub, selectedActivity, selectedDate),
      ),
    );
  }
}
