import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final void Function()? onTap;
  final Widget? child;

  const MyButton({
    super.key,
    required this.onTap,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12)
        ),
        padding: const EdgeInsets.all(15),
        child: child,
      ),
    );
  }
}