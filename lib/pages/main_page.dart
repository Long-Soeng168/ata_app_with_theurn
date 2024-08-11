import 'package:ata_app/pages/dtc/dtc_page.dart';
import 'package:ata_app/pages/garages/garage_page.dart';
import 'package:ata_app/pages/home/home_page.dart';
import 'package:ata_app/pages/shops/shop_page.dart';
import 'package:ata_app/pages/training/training_page.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> pages = [
    HomePage(),
    GaragesPage(),
    ShopPage(),
    DtcPage(),
    TrainingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home, size: 30),
          ),
          BottomNavigationBarItem(
            label: "Garage",
            icon: Icon(Icons.garage, size: 30),
          ),
          BottomNavigationBarItem(
            label: "Shop",
            icon: Icon(Icons.shopping_bag, size: 30),
          ),
          BottomNavigationBarItem(
            label: "DTC",
            icon: Icon(Icons.settings_input_component_rounded, size: 30),
          ),
          BottomNavigationBarItem(
            label: "Training",
            icon: Icon(Icons.model_training, size: 30),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey.shade500,
        onTap: _onItemTapped,
        backgroundColor: AppColors.greyWithOpacity,
      ),
    );
  }
}
