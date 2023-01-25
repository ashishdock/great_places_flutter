import 'package:http/http.dart' as http;
import 'dart:convert';

import '../secrets/secrets.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    const apiKey = Secrets.apiKey;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$apiKey';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${Secrets.apiKey}';
    final response = await http.get(url);
    print(json.decode(response.body)['results']);
    print(jsonDecode(response.body)['results']);
    return json.decode(response.body)['results'][0]["formatted_address"];
  }
}
