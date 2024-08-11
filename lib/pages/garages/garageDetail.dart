import 'package:ata_app/models/garage.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class GarageDetail extends StatelessWidget {
  final Garage garage;

  const GarageDetail({Key? key, required this.garage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          garage.name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: AppColors.onBackground, // Ensure this color is defined in app_colors.dart
        iconTheme: IconThemeData(
          color: AppColors.backArrowColor, // Set the color for the back arrow
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                garage.logo != null
                    ? 'https://bunjun.longsoeng.website/assets/images/garages/logo/${garage.logo}'
                    : 'https://bunjun.longsoeng.website/storage/default_garage_image.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
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
                  return Center(
                    child: Icon(
                      Icons.error,
                      size: 50,
                      color: Colors.red,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              garage.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.redAccent),
                SizedBox(width: 4),
                Text(
                  garage.location ?? 'No location available',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: index < garage.rate ? Colors.amber : Colors.grey,
                );
              }),
            ),
            SizedBox(height: 16),
            Text(
              garage.bio ?? 'No bio available',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
