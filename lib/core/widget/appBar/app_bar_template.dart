import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:plant_match/core/app_colors.dart';

class AppBarTemplate extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTemplate({
    super.key,
    required this.leadingWith,
    this.title,
    required this.centerTitle,
    required this.backgroundColor,
    this.shadowColor,
    required this.surfaceTintColor,
    required this.styleIconButton,
  });

  final double leadingWith;
  final String? title;
  final bool centerTitle;
  final Color backgroundColor;
  final Color? shadowColor;
  final Color surfaceTintColor;
  final ButtonStyle styleIconButton;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      leadingWidth: leadingWith,
      backgroundColor: backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 2,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        style: styleIconButton,
        icon: const Icon(LucideIcons.chevron_left, color: AppColors.greyDark),
      ),
    );
  }
}
