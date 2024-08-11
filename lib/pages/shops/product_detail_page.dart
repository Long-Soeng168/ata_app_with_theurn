import 'package:ata_app/components/my_button.dart';
import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetailPage extends StatelessWidget {
  
  final List<Product> relatedProducts = [
        Product(
          id: 2,
          name: 'Related Product 1',
          price: '19.99',
          image: 'https://via.placeholder.com/150',
        ),
        Product(
          id: 3,
          name: 'Related Product 2',
          price: null,
          image: 'https://via.placeholder.com/150',
        ),
      ];
  

  ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    print(product);

    if (product == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Product Not Found')),
        body: Center(
          child: Text('No product data available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Hero(
                  tag:  ApiConfig.baseImageUrl + 'products/thumb/' +  product.image,
                  child: Image.network(
                    ApiConfig.baseImageUrl + 'products/thumb/' +  product.image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                
                // Product Price
                Text(
                  product.price != null ? '\$${product.price}' : 'Price not available',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                const SizedBox(height: 16),
                
                // Shop Button
                MyButton(
                  onTap: () {
                    // Handle shop action
                  },
                  child: const Text('Shop Now'),
                ),
                const SizedBox(height: 32),
                
                // Related Products
                const Text(
                  'Related Products',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: relatedProducts.length,
                    itemBuilder: (context, index) {
                      final relatedProduct = relatedProducts[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: GestureDetector(
                          onTap: () {
                            // Handle related product tap
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                relatedProduct.image,
                                width: 150,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                relatedProduct.name,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                relatedProduct.price != null ? '\$${relatedProduct.price}' : 'Price not available',
                                style: const TextStyle(fontSize: 14, color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
