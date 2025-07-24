import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:dadoufit/src/domains/doinsport/api_response_wrapper.dart';
import 'package:dadoufit/src/domains/doinsport/club_playgound.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/doinsport/price.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:flutter/material.dart';

List<GenericSlot> mapToGenericSlots(
  ApiResponseWrapper<ClubPlayground> doinsportApiResponse,
  EnumClub clubEnum,
  EnumActivity activityEnum,
  DateTime day,
  Duration durationWanted,
) {
  final List<ClubPlayground> playgrounds = doinsportApiResponse.data;
  List<GenericSlot> genericSlots = [];
  final DateTime dateOnly = DateUtils.dateOnly(day);

  Map<DateTime, List<TempSlot>> slotOrganizer = {};

  for (var playground in playgrounds) {
    final String playgroundName = playground.name;
    for (var activity in playground.activities) {
      final EnumActivity activityEnum = EnumActivity.padel;
      for (var slot in activity.slots) {
        List<String> splitSlotStartTime = slot.startTime.split(":");
        final int slotStartHours = int.parse(splitSlotStartTime[0]);
        final int slotStartMinutes = int.parse(splitSlotStartTime[1]);
        final startTime = dateOnly.copyWith(
          hour: slotStartHours,
          minute: slotStartMinutes,
        );

        Price? selectedPrice = slot.prices.firstWhereOrNull(
          (p) => p.duration == durationWanted.inSeconds,
        );
        if (selectedPrice == null) {
          log("No selected Price");
          continue;
        }

        final tempSlot = TempSlot(
          startTime: startTime,
          club: clubEnum,
          activity: activityEnum,
          playgroundName: playgroundName,
          duration: Duration(seconds: selectedPrice.duration),
          bookable: selectedPrice.bookable,
        );

        if (!slotOrganizer.containsKey(startTime)) {
          slotOrganizer[startTime] = [];
        }
        slotOrganizer[startTime]!.add(tempSlot);
      }
    }
  }

  slotOrganizer.forEach((time, slots) {
    final playgrounds = slots
        .map(
          (slot) => SlotPlayground(
            bookable: slot.bookable,
            duration: slot.duration,
            playgroundName: slot.playgroundName,
          ),
        )
        .toList();
    playgrounds.sort((a, b) => a.playgroundName.compareTo(b.playgroundName));
    genericSlots.add(
      GenericSlot(
        startTime: time,
        club: clubEnum,
        activity: activityEnum,
        playgrounds: playgrounds,
      ),
    );
  });

  genericSlots.sort((a, b) => a.startTime.compareTo(b.startTime));

  return genericSlots;
}

class TempSlot {
  final DateTime startTime;
  final EnumClub club;
  final EnumActivity activity;
  final Duration duration;
  final String playgroundName;
  final bool bookable;

  TempSlot({
    required this.startTime,
    required this.club,
    required this.activity,
    required this.duration,
    required this.playgroundName,
    required this.bookable,
  });
}
