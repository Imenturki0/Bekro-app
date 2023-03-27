import 'package:flutter/material.dart';
import '../constants.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      this.backButton = false,
      this.onPress,
      this.mainTitle = true});
  final bool? backButton;
  final VoidCallback? onPress;
  final bool? mainTitle;

  @override
  Widget build(BuildContext context) {
    Widget? backWidget;
    Widget? titleWidget;
    if (backButton == true) {
      backWidget = IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: mainAppColor,
        ),
        onPressed: onPress,
      );
    }
    if (mainTitle == true) {
      titleWidget = const Text(
        'Bekron',
        style: TextStyle(
          color: mainAppColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return AppBar(
      leading: backWidget,
      backgroundColor: Colors.white,
      title: titleWidget,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
