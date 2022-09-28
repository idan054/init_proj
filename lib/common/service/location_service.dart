import 'dart:convert';
import 'package:http/http.dart' as http;


// source: https://stackoverflow.com/questions/57977167/device-country-in-flutter
Future<Map<String, dynamic>> getLocation(context) async {
  var response = await http.post(Uri.parse('http://ip-api.com/json'));
  if (response.statusCode == 200) {
    var respBody = jsonDecode(response.body);
    // print('resp ${response.body}');
    print('country ${respBody["country"]}');

    // Set on provider.
    // Location location = Location.fromJson(respBody);
    // kUserModel(context).updateUser(RilUser(location: location));

    return respBody;
  } else {
    return {'status': 'No data'};
  }
}

