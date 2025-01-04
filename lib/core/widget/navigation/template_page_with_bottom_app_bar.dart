import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/feature/auth/domain/entities/user_auth.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/auth/presentation/sign_up/presentation/sign_up_page.dart';
import 'package:plant_match/feature/home/presentation/home_page.dart';
import 'package:plant_match/feature/profil/presentation/profil_page.dart';

class TemplatePageWithBottomAppBar extends StatefulWidget {
  const TemplatePageWithBottomAppBar({super.key});

  @override
  State<TemplatePageWithBottomAppBar> createState() =>
      _TemplatePageWithBottomAppBarState();
}

class _TemplatePageWithBottomAppBarState
    extends State<TemplatePageWithBottomAppBar> {
  late int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserAuth? user = context.read<AuthCubit>().currentUser;
    final String uid = user!.uid;

    final List<Widget> pages = <Widget>[
      const HomePage(),
      const SignUpPage(),
      const Text('hello'),
      const Text('hello'),
      ProfilPage(uid: uid),
    ];

    return Scaffold(
        body: pages.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.black.withOpacity(0.05),
                blurRadius: 15.0,
              )
            ],
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.house),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.heart_handshake),
                label: 'Echanges',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.map_pin),
                label: 'A promixité',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.message_square_text),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.user),
                label: 'Mon profil',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            backgroundColor: AppColors.white,
            currentIndex: _selectedIndex,
            onTap: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ));
  }
}
