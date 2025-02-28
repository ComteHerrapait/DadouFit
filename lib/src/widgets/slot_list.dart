import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:flutter/material.dart';

class SlotList extends StatelessWidget {
  final List<GenericSlot> slots;

  const SlotList({super.key, required this.slots});

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return Text("Error, data is shitty");
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: slots.length,
      itemBuilder: (context, index) {
        return SlotListElement(slot: slots[index]);
      },
    );
  }
}

class SlotListElement extends StatelessWidget {
  final GenericSlot slot;

  const SlotListElement({super.key, required this.slot});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(slot.time),
      subtitle: SlotPlaygroundWidget(
        playgrounds: slot.playgrounds,
        activity: slot.activity,
      ),
    );
  }
}

class SlotPlaygroundWidget extends StatelessWidget {
  final List<SlotPlayground> playgrounds;
  final EnumActivity activity;

  const SlotPlaygroundWidget({
    super.key,
    required this.playgrounds,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children:
          playgrounds
              .map(
                (p) => Tooltip(
                  message: p.playgroundName,
                  child: Icon(
                    activity.icon,
                    color: p.bookable ? Colors.green : Colors.red,
                  ),
                ),
              )
              .toList(),
    );
  }
}
