class Price {
  final String id;
  final int duration;
  final int pricePerParticipant;
  final int participantCount;
  final bool bookable;

  Price({
    required this.id,
    required this.duration,
    required this.pricePerParticipant,
    required this.participantCount,
    required this.bookable,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      duration: json['duration'],
      pricePerParticipant: json['pricePerParticipant'],
      participantCount: json['participantCount'],
      bookable: json['bookable'],
    );
  }
}
