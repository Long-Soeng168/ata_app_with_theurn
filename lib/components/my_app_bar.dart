import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  List<Widget>? actions;
  Widget? title;
  bool? centerTitle;
  Color? foregroundColor;
  MyAppBar(
      {super.key,
      this.actions,
      this.title,
      this.centerTitle,
      this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
      foregroundColor: foregroundColor,
      centerTitle: false,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
