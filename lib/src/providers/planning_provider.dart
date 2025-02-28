import 'dart:developer';

import 'package:dadoufit/src/apis/doinsport_api.dart';
import 'package:dadoufit/src/domains/doinsport/api_response_wrapper.dart';
import 'package:dadoufit/src/domains/doinsport/club_playgound.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:dadoufit/src/mappers/doinsport_mapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlanningProvider extends ChangeNotifier {
  EnumClub selectedClub = EnumClub.pommeraie;
  EnumActivity selectedActivity = EnumActivity.padel;
  DateTime selectedDate = DateTime.now();
  Duration selectedDuration = Duration(minutes: 60);

  late Future<ApiResponseWrapper<ClubPlayground>> _rawData;

  String get selectedDateStr => DateFormat('EEEE d').format(selectedDate);
  String get selectionStr => [
    selectedClub.name,
    selectedActivity.name,
    "${selectedDuration.inMinutes}min",
    selectedDateStr,
  ].join(" | ");

  Future<List<GenericSlot>> planningsFuture() {
    return _rawData.then(
      (apiResponse) => Future.value(
        mapToGenericSlots(
          apiResponse,
          selectedClub,
          selectedActivity,
          selectedDate,
          selectedDuration,
        ),
      ),
    );
  }

  PlanningProvider() {
    _fetchApiData();
  }

  void selectClub(EnumClub? newClub) {
    if (newClub == null) {
      return;
    }
    selectedClub = newClub;
    log("updated selected club to $selectedClub");
    _fullUpdate();
  }

  void selectActivity(EnumActivity? newActivity) {
    if (newActivity == null) {
      return;
    }
    selectedActivity = newActivity;
    log("updated selected activity to $selectedActivity");
    _fullUpdate();
  }

  void selectDate(DateTime? newDateTime) {
    if (newDateTime == null) {
      return;
    }
    selectedDate = DateUtils.dateOnly(newDateTime);
    log("updated selected date to $selectedDate");
    _fullUpdate();
  }

  void selectDuration(Duration? newDuration) {
    if (newDuration == null) return;

    selectedDuration = newDuration;
    log("updated selected duration to ${selectedDuration.inMinutes}min");
    _softUpdate();
  }

  void _softUpdate() async {
    log("PlanningProvider : soft update triggered");
    notifyListeners();
  }

  void _fullUpdate() async {
    log("PlanningProvider : full update triggered");
    _fetchApiData();
    notifyListeners();
  }

  Future<Future<ApiResponseWrapper<ClubPlayground>>> _fetchApiData() async {
    log("PlanningProvider : fetching data from API");
    _rawData = getPlaygroundPlannings(
      selectedDate,
      selectedClub,
      selectedActivity,
    );
    return _rawData;
  }
}
