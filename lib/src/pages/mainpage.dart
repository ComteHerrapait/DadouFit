import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:dadoufit/src/providers/planning_provider.dart';
import 'package:dadoufit/src/utils/ContextExtension.dart';
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
        PlanningSelectors(),
        Expanded(
          child: FutureBuilder(
            future: plannings.planningsFuture(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: const CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Text('HTTP request KO : ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final List<GenericSlot> data = snapshot.data!;
                    return SlotList(slots: data);
                  } else {
                    throw Exception(
                      "Invalid State : not waiting, no data, no error $snapshot",
                    );
                  }
              }
            },
          ),
        ),
      ],
    );
  }
}

class PlanningSelectors extends StatefulWidget {
  const PlanningSelectors({super.key});

  @override
  State<PlanningSelectors> createState() => _PlanningSelectorsState();
}

class _PlanningSelectorsState extends State<PlanningSelectors> {
  bool areFiltersExpanded = false;

  Future<void> _selectDate(
    BuildContext context,
    PlanningProvider planningProvider,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: planningProvider.selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 14)),
    );
    planningProvider.selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final planningProvider = Provider.of<PlanningProvider>(context);

    return ExpansionTile(
      title: Text(context.translations.filterLabel),
      subtitle: areFiltersExpanded ? null : Text(planningProvider.selectionStr),
      leading: Icon(Icons.filter_alt),
      initiallyExpanded: areFiltersExpanded,
      onExpansionChanged: (value) => setState(() => areFiltersExpanded = value),
      children: [
        Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  DropdownMenu<EnumClub>(
                    initialSelection: planningProvider.selectedClub,
                    dropdownMenuEntries: EnumClub.values
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
                    initialSelection: planningProvider.selectedActivity,
                    dropdownMenuEntries: EnumActivity.values
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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context, planningProvider),
                      child: Text(planningProvider.selectedDateStr),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
