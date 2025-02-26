import 'package:dadoufit/src/domains/doinsport/price.dart';

class Slot {
  final String startTime;
  final List<Price> prices;

  const Slot({required this.startTime, required this.prices});

  factory Slot.fromJson(Map<String, dynamic> json) {
    var rawPrices = json['prices'] as List;
    List<Price> prices = rawPrices.map((item) => Price.fromJson(item)).toList();
    return Slot(startTime: json['startAt'], prices: prices);
  }
}
