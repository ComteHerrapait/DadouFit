import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:flutter/material.dart';

class SlotList extends StatelessWidget {
  final List<GenericSlot> slots;

  const SlotList({super.key, required this.slots});

  @override
  Widget build(BuildContext context) {
    if (slots == null || slots.length == 0) {
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
      dense: true,
      leading: Text(slot.playgroundName),
      title: Text(slot.toString()),
      trailing: Icon(slot.bookable ? Icons.event_available : Icons.event_busy),
    );
  }
}
