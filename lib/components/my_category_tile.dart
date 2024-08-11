import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/category.dart';
import 'package:flutter/material.dart';

class MyCategoryTile extends StatelessWidget {
  final Category category;
  const MyCategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.amber,
      ),
      // margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          // Product Image
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: AspectRatio(
                    aspectRatio: 1,
                    // child: Icon(Icons.favorite),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.network(
                        ApiConfig.baseImageUrl +
                            'categories/' +
                            category.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),

              // Product Name
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  // backgroundColor: Colors.amber,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
