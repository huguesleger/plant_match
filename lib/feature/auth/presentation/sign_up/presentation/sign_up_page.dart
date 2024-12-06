import 'package:flutter/material.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/core/widget/appBar/app_bar_template.dart';
import 'package:plant_match/core/widget/template/title_page.dart';
import 'package:plant_match/feature/auth/presentation/sign_up/widget/form_sign_up/form_sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTemplate(
        title: 'Inscrivez-vous',
        leadingWith: 80,
        centerTitle: false,
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        styleIconButton: IconButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: AppColors.greyLight),
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TitlePage(
                  title: 'Créer un compte',
                  isSubtitle: false,
                ),
              ),
              SizedBox(height: 50),
              FormSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
