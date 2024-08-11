import 'package:ata_app/components/my_product_tile.dart';
import 'package:ata_app/models/favorite.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {


  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<Favorite>().favorite;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        foregroundColor: AppColors.onPrimary,
        title: Text('Favorites'),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Cart List
            GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents the grid from scrolling separately
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 3 / 5,
                  ),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) =>
                      MyProductTile(product: favorites[index]),
                ),
          ],
        ),
      ),
    );
  }
}