import 'package:dadoufit/src/domains/doinsport/api_response_wrapper.dart';
import 'package:dadoufit/src/domains/doinsport/club_playgound.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:flutter/material.dart';

List<GenericSlot> mapToGenericSlots(
  ApiResponseWrapper<ClubPlayground> doinsportApiResponse,
  EnumClub clubEnum,
  EnumActivity activityEnum,
  DateTime day,
) {
  final List<ClubPlayground> playgrounds = doinsportApiResponse.data;
  List<GenericSlot> genericSlots = [];
  final DateTime dateOnly = DateUtils.dateOnly(day);

  // TODO : group slots by starting time, multiple duration give multiple slots right now
  for (var playground in playgrounds) {
    for (var activity in playground.activities) {
      for (var slot in activity.slots) {
        List<String> splitSlotStartTime = slot.startTime.split(":");
        final int slotStartHours = int.parse(splitSlotStartTime[0]);
        final int slotStartMinutes = int.parse(splitSlotStartTime[1]);

        for (var price in slot.prices) {
          final startTime = dateOnly.copyWith(
            hour: slotStartHours,
            minute: slotStartMinutes,
          );
          genericSlots.add(
            GenericSlot(
              bookable: price.bookable,
              duration: Duration(seconds: price.duration),
              startTime: startTime,
              playgroundName: playground.name,
              clubName: clubEnum.name,
              activityName: activityEnum.name,
            ),
          );
        }
      }
    }
  }

  return genericSlots;
}
