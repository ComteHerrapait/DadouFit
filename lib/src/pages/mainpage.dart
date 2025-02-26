import 'package:dadoufit/src/apis/doinsport_api.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:dadoufit/src/mappers/doinsport_mapper.dart';
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
    return Center(
      child: FutureBuilder(
        future: futureGenericSlots,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<GenericSlot> data = snapshot.data!;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final slot = data[index];

                return ListTile(
                  dense: true,
                  leading: Text(slot.playgroundName),
                  title: Text(slot.toString()),
                  trailing: Icon(
                    slot.bookable ? Icons.event_available : Icons.event_busy,
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('HTTP request KO :  ${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
