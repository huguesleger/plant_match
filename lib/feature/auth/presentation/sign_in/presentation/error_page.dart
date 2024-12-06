import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_match/core/app_colors.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SvgPicture.asset('assets/logo/logo_color.svg'),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Oups ! une erreur est survénue',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Chillax',
                  fontWeight: FontWeight.w600,
                  color: AppColors.blueGreen,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(errorMessage),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height > 700 ? 45 : 25),
              SizedBox(
                height: MediaQuery.of(context).size.height > 700 ? 373 : 280,
                child: Image.asset('assets/images/auth/error.png'),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height > 700 ? 45 : 25),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.greyLight),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    LucideIcons.arrow_left,
                    color: AppColors.blueGreen,
                  ),
                  label: const Text(
                    'Retour',
                    style: TextStyle(
                      color: AppColors.blueGreen,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
