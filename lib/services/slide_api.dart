import 'dart:convert';
import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/slide.dart';
import 'package:http/http.dart' as http;


class SlideApi {
  // static Future<List<Slide>> fetchHomeSlides() async {
  //   const String apiUrl = '${ApiConfig.baseApiUrl}/slides';
  //   final response = await http.get(Uri.parse(apiUrl));

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

  //     if (jsonResponse.containsKey('slides') && jsonResponse['slides'] != null) {
  //       final List<dynamic> slidesJson = jsonResponse['slides'];
  //       return slidesJson.map((json) => Slide.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load slides: Slides field is missing or null');
  //     }
  //   } else {
  //     throw Exception('Failed to load slides');
  //   }
  // }

  static Future<List<Slide>> fetchHomeSlides() async {
    // print('fetchProducts called');

    // Use the base URL from the ApiConfig class
    const url = '${ApiConfig.baseApiUrl}/slides';

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body) as Map<String, dynamic>;

      // Access the 'data' key which contains the list of products
      final results = json['slides'] as List<dynamic>;

      // Transform JSON data into a list of Product objects
      final slides = results.map((e) {
        return Slide(
          id: e['id'],
          image: e['image'] ?? '',
        );
      }).toList();

      print(slides);

      return slides;

    } else {
      return [];
    }
  }
}

