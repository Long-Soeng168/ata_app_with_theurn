import 'package:ata_app/components/my_icon_button.dart';
import 'package:ata_app/config/api_config.dart';
import 'package:ata_app/models/product.dart';
import 'package:ata_app/models/favorite.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductTile extends StatelessWidget {
  final Product product;

  const MyProductTile({super.key, required this.product});

  void addToFavorite(BuildContext context) {
    context.read<Favorite>().addToFavorite(product);
  }

  void removeFromFavorite(BuildContext context) {
    context.read<Favorite>().removeFromFavorite(product);
  }

  @override
  Widget build(BuildContext context) {

    final favorites = context.watch<Favorite>().favorite;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product_detail_page', arguments: product);
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(10),
        ),
        // margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Product Image
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: AspectRatio(
                      aspectRatio: 1,
                      // child: Icon(Icons.favorite),
                      child: Hero(
                        tag: product.image,
                        child: Image.network(
                          ApiConfig.baseImageUrl + 'products/thumb/' +  product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
      
                // Product Name
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
      
            // Product Price + btn add to favorite
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$' + (product.price ?? '0.0'), style: TextStyle(fontSize: 14, color: Colors.red.shade400),),
                  Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      // color: AppColors.background,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: MyIconButton(
                      onTap: () => favorites.contains(product)
                            ? removeFromFavorite(context)
                            : addToFavorite(context),
                      child:Icon(
                          favorites.contains(product)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
