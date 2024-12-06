import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/core/widget/appBar/app_bar_dynamic_header.dart';
import 'package:plant_match/core/widget/template/title_page.dart';
import 'package:plant_match/feature/auth/presentation/sign_in/widget/form_sign_in/form_sign_in.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key, required this.toggleAuth});

  final void Function() toggleAuth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarDynamicHeader(
        height: MediaQuery.of(context).size.height > 700 ? 345 : 250,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: IconButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColors.white,
          ),
          icon: const Icon(LucideIcons.chevron_left, color: AppColors.greyDark),
        ),
        titlePadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height > 700 ? 140 : 70,
            top: 50),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: TitlePage(
                    title: 'Hey! Bienvenue',
                    isSubtitle: false,
                  ),
                ),
                FormSignIn(toggleAuth: toggleAuth),
              ],
            ),
          ),
        ),
        backgroundAppBar: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/auth/login.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
    );
  }
}
