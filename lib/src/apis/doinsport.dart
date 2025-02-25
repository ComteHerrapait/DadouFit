import 'dart:convert';

import 'package:dadoufit/src/domains/doinsport/api_response_wrapper.dart';
import 'package:dadoufit/src/domains/doinsport/club_playgound.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> proofOfConcept() async {
  final response = await http.get(
    Uri.parse(
      'https://api-v3.doinsport.club/clubs/playgrounds/plannings/2025-02-27?club.id=0e5db60e-1735-4f5e-92f4-b457ac72f912&from=20:00:00&to=23:59:59&activities.id=ce8c306e-224a-4f24-aa9d-6500580924dc&bookingType=unique',
    ),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    throw Exception('Failed to load album');
  }
}

Future<ApiResponseWrapper<ClubPlaygound>> getPlaygrounds() async {
  final response = await http.get(
    Uri.parse(
      'https://api-v3.doinsport.club/clubs/playgrounds/plannings/2025-02-27?club.id=0e5db60e-1735-4f5e-92f4-b457ac72f912&from=20:00:00&to=23:59:59&activities.id=ce8c306e-224a-4f24-aa9d-6500580924dc&bookingType=unique',
    ),
  );
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 200) {
    return ApiResponseWrapper.fromJson(json, ClubPlaygound.fromJson);
  } else {
    throw Exception('Failed to load club playgrounds');
  }
}
