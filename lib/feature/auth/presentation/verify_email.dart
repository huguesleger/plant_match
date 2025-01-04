import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/core/widget/bottomSheet/bottom_sheet.dart';
import 'package:plant_match/core/widget/navigation/template_page_with_bottom_app_bar.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_state.dart';
import 'package:plant_match/feature/home/presentation/home_page.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  Timer? timer;
  late final AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = BlocProvider.of<AuthCubit>(context);
    _checkVerificationStatusPeriodically();
  }

  void _checkVerificationStatusPeriodically() {
    Future.delayed(const Duration(seconds: 5), () async {
      await authCubit.refreshUserAndCheckVerification();
      if (mounted) {
        _checkVerificationStatusPeriodically(); // Continue la vérification si la page est toujours montée
      }
    });
  }

/*  void _checkEmailVerification() {
    BlocProvider.of<AuthCubit>(context).checkEmailVerified();
  }*/

  void _sendVerificationEmail() {
    BlocProvider.of<AuthCubit>(context).sendVerificationEmail();
  }

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<AuthCubit>(context).currentUser;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              // Afficher un message de succès si l'email est vérifié
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Votre email est vérifié !')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const TemplatePageWithBottomAppBar()),
              );
            }
            if (state is AuthError) {
              // Afficher un message d'erreur
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
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
                    'Vérifiez votre adresse e-mail',
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
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Un e-mail à été envoyé sur votre adresse \n',
                          style: const TextStyle(
                            color: AppColors.black,
                          ),
                          children: [
                            TextSpan(
                              text: user?.email,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(
                              text: '\nMerci de cliquez sur le lien.',
                            )
                          ],
                        )),
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height > 700 ? 45 : 25),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height > 700 ? 373 : 280,
                    child: Image.asset('assets/images/auth/verify_email.png'),
                  ),
                  SizedBox(
                      height:
                          MediaQuery.of(context).size.height > 700 ? 45 : 25),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        authCubit.sendVerificationEmail();
                      },
                      child: const Text("Envoyer"),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.greyLight),
                      ),
                      onPressed: () {
                        authCubit.logOut();
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
            );
          },
        ),
      ),
    );
  }
}
