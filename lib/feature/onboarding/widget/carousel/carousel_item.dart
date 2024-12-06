import 'package:flutter/material.dart';
import 'package:plant_match/core/app_colors.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  final String title;
  final String description;
  final String image;

  static const double defaultHeightImg = 315;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height:
              MediaQuery.of(context).size.height > 900 ? defaultHeightImg : 250,
          child: Image.asset(image),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height > 700 ? 50 : 30),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              color: AppColors.blueGreen,
              fontFamily: 'Chillax',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height > 700 ? 20 : 10,
          ),
          child: Text(description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
              )),
        ),
      ],
    );
  }
}
