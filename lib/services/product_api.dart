import 'dart:convert';

import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductApi {

  static Future<List<Product>> fetchProducts() async {
    // print('fetchProducts called');

    // Use the base URL from the ApiConfig class
    const url = '${ApiConfig.baseApiUrl}/products';

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body) as Map<String, dynamic>;

      // Access the 'data' key which contains the list of products
      final results = json['data'] as List<dynamic>;

      // Transform JSON data into a list of Product objects
      final products = results.map((e) {
        return Product(
          id: e['id'],
          name: e['name'] ?? '',
          price:e['price'] ?? '',
          image: e['image'] ?? '',
        );
      }).toList();

      // print(products);

      return products;

    } else {
      return [];
    }
  }
}