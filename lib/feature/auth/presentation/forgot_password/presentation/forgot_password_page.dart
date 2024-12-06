import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/feature/auth/presentation/forgot_password/widget/form_forgot_password/form_forgot_password.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Chillax',
                    fontWeight: FontWeight.w600,
                    color: AppColors.blueGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Center(
                  child: Text(
                    'Entrez votre e-mail pour réinitialiser le mot de passe',
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  height: MediaQuery.of(context).size.height > 700 ? 373 : 280,
                  child: Image.asset('assets/images/auth/forgot_password.png'),
                ),
                const SizedBox(height: 25),
                const FormForgotPassword(),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
