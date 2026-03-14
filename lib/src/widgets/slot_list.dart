import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/generic_slot.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      onTap: () => showDialog<String>(
        context: context,
        builder: (context) => SlotDialog(slot: slot),
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
      children: playgrounds
          .map(
            (p) => Tooltip(
              message: p.playgroundName,
              child: PlaygroundAvailabilityIcon(
                icon: activity.icon,
                isAvailable: p.bookable,
              ),
            ),
          )
          .toList(),
    );
  }
}

class SlotDialog extends StatelessWidget {
  final GenericSlot slot;

  const SlotDialog({super.key, required this.slot});

  Future<void> _openBookingPage(BuildContext context) async {
    final Uri uri = slot.club.getSelectBookingUri(slot.activity);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch uri $uri');
    }
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Text("Slot ${slot.time}"),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Reduce size to minimum
          children: [
            Text(
              "Available Playgrounds : ${slot.availablePlaygroundCount}/${slot.playgroundCount}",
            ),
            SlotPlaygroundWidget(
              playgrounds: slot.playgrounds,
              activity: slot.activity,
            ),
            if (slot.isAnyBookable) ...[
              Divider(),
              Text(
                "Work In Progress : link does not redirect to correct time on website",
                textScaler: TextScaler.linear(0.7),
                style: TextStyle(color: Colors.orangeAccent),
              ),
            ],
          ],
        ),
      ),
      actions: [
        slot.isAnyBookable
            ? TextButton(
                onPressed: () => _openBookingPage(context),
                child: Text("Go to booking page"),
              )
            : TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
      ],
    );
  }
}

class PlaygroundAvailabilityIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final bool isAvailable;

  const PlaygroundAvailabilityIcon({
    super.key,
    required this.icon,
    required this.isAvailable,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(icon, size: size, color: isAvailable ? Colors.green : Colors.grey),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: isAvailable ? Colors.green : Colors.red,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            child: Icon(
              isAvailable ? Icons.check : Icons.close,
              size: size * 0.4,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
