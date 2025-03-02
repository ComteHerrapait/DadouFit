import 'package:dadoufit/src/domains/doinsport/enum_activity.dart';

enum EnumClub {
  pommeraie(
    id: "0e5db60e-1735-4f5e-92f4-b457ac72f912",
    websiteHost: "lapommeraie.doinsport.club",
  ),
  stadium(
    id: "cda49d78-525c-4f66-b6f8-43001c8a6ad7",
    websiteHost: "stadium.doinsport.club",
  ),
  area(
    id: "b78e6114-96e3-4f20-82c8-cc213cdd47d3",
    websiteHost: "areapadelcaen.doinsport.club",
  )
  // padelshot(id: "93430e85-c51e-4fab-9c30-f0e490e5fdc6") // empty
  ;

  const EnumClub({required this.id, this.websiteHost});

  final String id;
  final String? websiteHost;

  Uri getWebsiteUri(String path) {
    return getWebsiteUriWithParams(path, null);
  }

  Uri getWebsiteUriWithParams(
    String path,
    Map<String, dynamic>? queryParameters,
  ) {
    if (null == websiteHost) {
      throw Exception('Club $name has no website url !');
    }
    return Uri(
      scheme: "https",
      host: websiteHost,
      path: path,
      queryParameters: queryParameters,
    );
  }

  Uri getSelectBookingUri(EnumActivity activity) {
    return getWebsiteUriWithParams("select-booking", {
      "guid": id,
      "categoryId": activity.id,
    });
  }
}
