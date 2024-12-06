import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/feature/onboarding/presentation/onboarding_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.blueGreen,
      body: Stack(
        children: [
          _BgIntro(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Logo(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: _ContentIntro(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BgIntro extends StatelessWidget {
  const _BgIntro();

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_intro.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _ContentIntro extends StatelessWidget {
  const _ContentIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Échangez, adoptez et cultivez ensemble.',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Chillax',
            color: AppColors.greenLight,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 70),
          child: Text(
            'Rejoignez la communauté des amoureux des plantes près de chez vous.',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnboardingPage(),
                      ),
                    );
                  },
                  child: const Text('C\'est parti !'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: SvgPicture.asset('assets/logo/logo_white.svg'),
      ),
    );
  }
}
