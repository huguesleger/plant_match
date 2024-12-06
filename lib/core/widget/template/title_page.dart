import 'package:flutter/material.dart';
import 'package:plant_match/core/app_colors.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSubtitle,
  });

  final String title;
  final String? subtitle;
  final bool isSubtitle;

  @override
  Widget build(BuildContext context) {
    return isSubtitle != true
        ? Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontFamily: 'Chillax',
              color: AppColors.blueGreen,
              fontWeight: FontWeight.w600,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 32,
                  fontFamily: 'Chillax',
                  color: AppColors.blueGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.blueGreen,
                ),
              ),
            ],
          );
  }
}
