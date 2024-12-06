import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/intro/presentation/intro_page.dart';
import 'package:plant_match/feature/profil/presentation/cubit/profil_cubit.dart';
import 'package:plant_match/feature/profil/presentation/cubit/profil_state.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key, required this.uid});

  final String uid;

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late final authCubit = context.read<AuthCubit>();
  late final profilCubit = context.read<ProfilCubit>();

  late UserAuth? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();
    profilCubit.getProfilUser(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilCubit, ProfilState>(builder: (context, state) {
      if (state is ProfilLoaded) {
        final user = state.profilUser;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Text(user.name),
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
        );
      } else if (state is ProfilLoading) {
        return const CircularProgressIndicator();
      } else {
        return const Text('Profil introuvable');
      }
    });
  }
}
