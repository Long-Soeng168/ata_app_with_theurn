import 'package:ata_app/models/garagePost.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  final Garagepost post;

  const PostDetail({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.name),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                'https://bunjun.longsoeng.website/assets/images/garageposts/${post.image}',
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                  return Center(child: Icon(Icons.error, size: 50));
                },
              ),
            ),
            SizedBox(height: 16),
            Text(post.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
