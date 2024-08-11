import 'dart:convert';
import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/garage.dart';
import 'package:http/http.dart' as http;

Future<List<Garage>> fetchGarages() async {
  const String apiUrl = '${ApiConfig.baseApiUrl}garages';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // print(data);
    final garagetsJson = data['data'] as List;
    return garagetsJson.map((json) => Garage.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}
