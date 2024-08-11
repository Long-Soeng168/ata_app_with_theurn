import 'package:ata_app/components/my_list_tile.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Drawer header: logo
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.car_rental_rounded,
                  size: 72,
                  color: AppColors.text,
                ),
              ),
              
              const SizedBox(
                height: 24,
              ),
              // home tile
              MyListTile(
                text: 'Home',
                icon: Icons.home,
                onTap: () => Navigator.pop(context),
              ),
              
              // cart tile
              MyListTile(
                text: 'Favorite',
                icon: Icons.favorite,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/favorite_page');
                },
              ),
            ],
          ),

          // exit
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: MyListTile(
              text: 'Login',
              icon: Icons.login,
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, '/login_page');
              },
            ),
          )
        ],
      ),
    );
  }
}
