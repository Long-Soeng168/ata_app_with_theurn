import 'package:ata_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {

  final void Function()? onTap;
  final Widget? child;

  const MyIconButton({
    super.key,
    required this.onTap,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: child,
      ),
    );
  }
}