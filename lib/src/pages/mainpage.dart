import 'package:dadoufit/src/apis/doinsport_api.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:dadoufit/src/mappers/doinsport_mapper.dart';
import 'package:dadoufit/src/widgets/slot_list.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<GenericSlot>> futureGenericSlots;

  @override
  void initState() {
    super.initState();
    futureGenericSlots = getPlaygroundPlannings(
      DateTime.now().copyWith(day: 28),
      EnumClub.pommeraie,
      EnumActivity.padel,
    ).then(
      (value) => Future.value(
        mapToGenericSlots(
          value,
          EnumClub.pommeraie,
          EnumActivity.padel,
          DateTime.now(),
        ),
      ),
    );
  }

  // TODO : improve UI
  // * look into this lib for better UI : calendar_view

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownMenu<EnumClub>(
              initialSelection: EnumClub.pommeraie,
              dropdownMenuEntries:
                  EnumClub.values
                      .map(
                        (EnumClub club) => DropdownMenuEntry<EnumClub>(
                          value: club,
                          label: club.name,
                        ),
                      )
                      .toList(),
            ),
            DropdownMenu<EnumActivity>(
              initialSelection: EnumActivity.padel,
              dropdownMenuEntries:
                  EnumActivity.values
                      .map(
                        (EnumActivity activity) =>
                            DropdownMenuEntry<EnumActivity>(
                              value: activity,
                              label: activity.name,
                            ),
                      )
                      .toList(),
            ),
          ],
        ),
        Divider(),
        Expanded(
          child: FutureBuilder(
            future: futureGenericSlots,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<GenericSlot> data = snapshot.data!;

                return SlotList(slots: data);
              } else if (snapshot.hasError) {
                return Text('HTTP request KO :  ${snapshot.error}');
              }
              return Center(child: const CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
