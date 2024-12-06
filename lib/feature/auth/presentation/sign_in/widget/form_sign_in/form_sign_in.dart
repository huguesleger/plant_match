import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/core/widget/form/form_text_field.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_state.dart';
import 'package:plant_match/feature/auth/presentation/forgot_password/presentation/forgot_password_page.dart';
import 'package:plant_match/feature/auth/presentation/sign_in/widget/form_sign_in/sign_in_with_social.dart';
import 'package:plant_match/feature/home/presentation/home_page.dart';
import 'package:toastification/toastification.dart';

class FormSignIn extends StatefulWidget {
  const FormSignIn({super.key, required this.toggleAuth});

  final void Function() toggleAuth;

  @override
  State<FormSignIn> createState() => _FormSignInState();
}

class _FormSignInState extends State<FormSignIn> {
  final formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = true;

  void onPressedSignIn() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.signInWithEmailAndPassword(email: email, password: password);
    } else {
      toastification.show(
        context: context,
        title: const Text('Veuillez remplir tous les champs'),
        autoCloseDuration: const Duration(seconds: 5),
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        showProgressBar: false,
      );
    }
    formKey.currentState?.saveAndValidate() ?? false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      },
      builder: (context, authState) {
        if (authState is AuthLoading) {
          return const Expanded(
            child: SizedBox(
              height: double.infinity,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return FormBuilder(
          key: formKey,
          child: Column(
            children: [
              FormTextField(
                name: 'email',
                label: 'E-mail',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText: false,
                controller: _emailController,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Ce champ est requis'),
                  FormBuilderValidators.email(
                      errorText: 'Entrez un e-mail valide'),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              FormTextField(
                name: 'password',
                label: 'Mot de passe',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscureText: _isPasswordVisible,
                controller: _passwordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? LucideIcons.eye_off : LucideIcons.eye,
                    color: AppColors.greyDark,
                  ),
                  onPressed: () {
                    setState(
                      () {
                        _isPasswordVisible = !_isPasswordVisible;
                      },
                    );
                  },
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                      errorText: 'Ce champ est requis'),
                  FormBuilderValidators.password(
                      errorText: 'Entre un mot de passe valide'),
                ]),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    onPressedSignIn();
                  },
                  child: const Text("S'identifier"),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage()));
                },
                child: Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Mot de passe oublié ?',
                      style: TextStyle(
                        color: AppColors.blueGreen,
                        decoration: TextDecoration.underline,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Pas encore de compte ? ',
                    style: const TextStyle(
                        color: AppColors.greyDark, fontSize: 11),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggleAuth();
                          },
                        text: 'Créer un compte',
                        style: const TextStyle(
                            color: AppColors.blueGreen,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
              const SignInWithSocial(),
            ],
          ),
        );
      },
    );
  }
}
