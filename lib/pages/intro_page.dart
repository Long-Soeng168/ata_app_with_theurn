import 'package:ata_app/components/my_button.dart';
import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.car_repair_sharp,
              size: 72,
              color: AppColors.text,
            ),
            const SizedBox(height: 25),
            const Text(
              'ATA E-Commerce',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Everything in one place',
              style: TextStyle(
                color: AppColors.textLight,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            MyButton(
              onTap: () => Navigator.pushReplacementNamed(context, '/main_page'),
              child: Icon(Icons.arrow_forward, color: AppColors.onPrimary,),
            ),
          ],
        ),
      ),
    );
  }
}
