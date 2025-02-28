import 'package:flutter/material.dart';

enum EnumActivity {
  padel(id: "ce8c306e-224a-4f24-aa9d-6500580924dc", icon: Icons.sports_tennis),
  badminton(
    id: "541b8d8a-3ce2-4f46-913c-5e6e4d9b5dea",
    icon: Icons.sports_tennis,
  ),
  tennis(id: "d632b23c-413b-4f61-959e-f9e95c600f96", icon: Icons.sports_tennis);

  const EnumActivity({required this.id, required this.icon});

  final String id;
  final IconData icon;
}
