import 'package:flutter/material.dart';
import 'package:ata_app/models/garage.dart'; // Update with the correct path
import 'package:ata_app/models/garagePost.dart'; // Update with the correct path
import 'package:ata_app/services/garage_api.dart'; // Update with the correct path
import '../../config/api_config.dart';
import 'garage_post_detail_page.dart'; // Update with the correct path
import 'package:ata_app/themes/app_colors.dart'; // Update with the correct path

class GarageDetailPage extends StatelessWidget {
  final Garage garage;

  const GarageDetailPage({Key? key, required this.garage}) : super(key: key);

  Future<List<Garagepost>> _fetchGaragePosts() async {
    return await GarageApi
        .fetchGaragePosts(); // Adjust based on your API method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          garage.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // fontSize: 24,
          ),
        ),
        // backgroundColor: AppColors.onBackground,
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: AppColors
              .backArrowColor, // Ensure AppColors.backArrowColor is defined
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  garage.logo != null
                      ? '${ApiConfig.baseImageUrl}garages/banner/${garage.banner}'
                      : 'https://bunjun.longsoeng.website/storage/default_garage_image.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
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
                      width: double.infinity,
                      height: 200,
                    );
                  },
                ),
              ),
              SizedBox(height: 4),
              Container(
                // padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: AppColors.greyWithOpacity),
                child: Column(
                  children: [
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              '${ApiConfig.baseImageUrl}garages/logo/${garage.logo}',
                              fit: BoxFit.cover,
                              width: 90,
                              height: 90,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Image.asset(
                                  'assets/images/image_default.png',
                                  // Path to your default image
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              garage.name,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            SizedBox(height: 8),
                            Text(
                              garage.bio ?? 'No bio available',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.redAccent),
                                SizedBox(width: 4),
                                Text(
                                  garage.location ?? 'No location available',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < garage.rate
                                      ? Colors.amber
                                      : Colors.grey,
                                );
                              }),
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ],
                    ),
                    // TextButton(onPressed: (){}, child: Icon(Icons.cake_sharp))
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Text(
              //   'Posts:',
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              Container(
                height: 5,
                decoration: BoxDecoration(color: AppColors.greyWithOpacity,borderRadius: BorderRadius.circular(5)),
              ),
              SizedBox(height: 16),
              FutureBuilder<List<Garagepost>>(
                future: _fetchGaragePosts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No posts found'));
                  } else {
                    final posts = snapshot.data!;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GaragePostDetailPage(post: post),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.all(8.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(8.0),
                              leading: SizedBox(
                                width: 100, // Set a fixed width for the image
                                height: 100, // Set a fixed height for the image
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    '${ApiConfig.baseImageUrl}garageposts/${post.image}',
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return Image.asset(
                                        'assets/images/image_default.png',
                                        // Path to your default image
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              title: Text(
                                post.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 24,
                                ),
                              ),
                              subtitle: Text(post.description),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
