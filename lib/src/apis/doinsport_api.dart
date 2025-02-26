import 'dart:convert';

import 'package:dadoufit/src/domains/doinsport/api_response_wrapper.dart';
import 'package:dadoufit/src/domains/doinsport/club_playgound.dart';
import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';
import 'package:dadoufit/src/domains/doinsport/enum_club.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const String hostDoinsportV3 = "api-v3.doinsport.club";

Future<ApiResponseWrapper<ClubPlaygound>> getPlaygroundPlannings(
  DateTime date,
  EnumClub club,
  EnumActivity activity,
) async {
  String dateStr = DateFormat('yyyy-MM-dd').format(date);
  final uri = Uri(
    scheme: 'https',
    host: hostDoinsportV3,
    path: '/clubs/playgrounds/plannings/$dateStr',
    queryParameters: {
      'club.id': club.id,
      'from': '00:00:00',
      'to': '23:59:59',
      'activities.id': activity.id,
      'bookingType': 'unique',
    },
  );

  final response = await http.get(uri);

  final json = jsonDecode(response.body) as Map<String, dynamic>;
  if (response.statusCode == 200) {
    return ApiResponseWrapper.fromJson(json, ClubPlaygound.fromJson);
  } else {
    throw Exception('Failed to load club playgrounds');
  }
}
