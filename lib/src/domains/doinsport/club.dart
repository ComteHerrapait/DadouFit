class Club {
  final String id;
  final String name;
  final Uri websiteUrl;
  final Uri logoUrl;

  Club({
    required this.id,
    required this.name,
    required this.websiteUrl,
    required this.logoUrl,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      websiteUrl: Uri.parse(json['websiteUrl'] as String),
      logoUrl: Uri.parse(json['logo']['contentUrl'] as String),
    );
  }
}
