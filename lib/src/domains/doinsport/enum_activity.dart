import 'package:flutter/material.dart';

enum EnumActivity {
  padel(id: "ce8c306e-224a-4f24-aa9d-6500580924dc", icon: Icons.sports_tennis);

  const EnumActivity({required this.id, required this.icon});

  final String id;
  final IconData icon;
}
