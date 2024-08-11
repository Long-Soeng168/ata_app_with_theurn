import 'dart:convert';

import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryApi {

  static Future<List<Category>> fetchCategories() async {
    // print('fetchProducts called');

    // Use the base URL from the ApiConfig class
    const url = '${ApiConfig.baseApiUrl}/categories';

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body) as List<dynamic>;


      // Transform JSON data into a list of Product objects
      final categories = json.map((e) {
        return Category(
          id: e['id'],
          name: e['name'] ?? '',
          nameKh: e['name_kh'] ?? '',
          image: e['image'] ?? '',
        );
      }).toList();

      // print(categories);

      return categories;

    } else {
      return [];
    }
  }
}