import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:dadoufit/src/providers/planning_provider.dart';
import 'package:dadoufit/src/widgets/slot_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlanningProvider()),
      ],
      child: MainPageContent(),
    );
  }
}

class MainPageContent extends StatelessWidget {
  const MainPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final plannings = Provider.of<PlanningProvider>(context);

    return Column(
      children: [
        PlanningSelectors(planningProvider: plannings),
        Divider(),
        Expanded(
          child: FutureBuilder(
            future: plannings.planningsFuture(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<GenericSlot> data = snapshot.data!;
                return SlotList(slots: data);
              } else if (snapshot.hasError) {
                return Text('HTTP request KO :  ${snapshot.error}');
              } else {
                return Center(child: const CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

class PlanningSelectors extends StatelessWidget {
  const PlanningSelectors({super.key, required this.planningProvider});

  final PlanningProvider planningProvider;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            direction: Axis.horizontal,
            children: [
              DropdownMenu<EnumClub>(
                initialSelection: planningProvider.selectedClub,
                dropdownMenuEntries:
                    EnumClub.values
                        .map(
                          (EnumClub club) => DropdownMenuEntry<EnumClub>(
                            value: club,
                            label: club.name,
                          ),
                        )
                        .toList(),
                onSelected: planningProvider.selectClub,
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
                onSelected: planningProvider.selectActivity,
              ),
              DropdownMenu<Duration>(
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: Duration(minutes: 60),
                    label: "60 min",
                  ),
                  DropdownMenuEntry(
                    value: Duration(minutes: 90),
                    label: "90 min",
                  ),
                ],
                onSelected: planningProvider.selectDuration,
                initialSelection: planningProvider.selectedDuration,
              ),
            ],
          ),
        ),
        // DatePickerDialog(
        //   initialCalendarMode: DatePickerMode.day,
        //   initialEntryMode: DatePickerEntryMode.inputOnly,
        //   initialDate: DateTime.now(),
        //   firstDate: DateTime.now(),
        //   lastDate: DateTime.now().add(Duration(days: 14)),
        // ),
      ],
    );
  }
}
