
class ClubPlaygound {
  final String id;
  final String name;
  final bool indoor;

  const ClubPlaygound({
    required this.id,
    required this.name,
    required this.indoor,
  });

  factory ClubPlaygound.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': String id, 'name': String name, 'indoor': bool indoor} =>
        ClubPlaygound(id: id, name: name, indoor: indoor),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
  
}
