import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/intro/presentation/intro_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserAuth? currentUser = context.read<AuthCubit>().currentUser;
    print(currentUser?.name);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const Text('Home Page'),
              const SizedBox(height: 20),
              Text('Welcome ${currentUser?.name}'),
              Text('Email: ${currentUser?.email}'),
              InkWell(
                onTap: () {
                  context.read<AuthCubit>().logOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const IntroPage(),
                    ),
                  );
                },
                child: const Text('deconnecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
