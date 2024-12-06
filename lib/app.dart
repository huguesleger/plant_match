import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_match/core/theme_plant_match.dart';
import 'package:plant_match/feature/auth/data/firebase_auth_repo.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_state.dart';
import 'package:plant_match/feature/auth/presentation/sign_in/presentation/error_page.dart';
import 'package:plant_match/feature/home/presentation/home_page.dart';
import 'package:plant_match/feature/intro/presentation/intro_page.dart';
import 'package:plant_match/feature/profil/data/firebase_profil_repo.dart';
import 'package:plant_match/feature/profil/presentation/cubit/profil_cubit.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authRepository = FirebaseAuthRepo();
  final profilRepository = FirebaseProfilRepo();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepository: authRepository)..checkCurrentUser(),
        ),
        BlocProvider<ProfilCubit>(
            create: (context) =>
                ProfilCubit(profilRepository: profilRepository)),
      ],
      child: MaterialApp(
        title: 'PlantMatch',
        theme: PlantMatchTheme.defaultTheme,
        color: PlantMatchTheme.defaultTheme.primaryColor,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            print(authState);
            if (authState is Unauthenticated) {
              return const IntroPage();
            }
            if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, authState) {
            if (authState is AuthError) {
/*              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(authState.message),
                ),
              );*/
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ErrorPage(errorMessage: authState.message),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
