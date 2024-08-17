import 'package:ata_app/models/garagePost.dart';
import 'package:flutter/material.dart';

import '../../config/api_config.dart';

class GaragePostDetailPage extends StatelessWidget {
  final Garagepost post;

  const GaragePostDetailPage({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          post.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  '${ApiConfig.baseImageUrl}garageposts/${post.image}',
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      'assets/images/image_default.png',
                      // Path to your default image
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.name,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.blue)),
                    SizedBox(height: 8),
                    Text(post.description),
                    SizedBox(height: 16),
                    Text('Author: ${post.createByUserId}'),
                    SizedBox(height: 8),
                    Text('Published on: ${post.garageId}'),
                    SizedBox(height: 8),
                    Text('Post At: ${post.updatedAt}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
