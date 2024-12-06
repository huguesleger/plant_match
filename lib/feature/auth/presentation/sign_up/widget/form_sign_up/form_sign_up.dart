import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/core/widget/form/checkbox_field.dart';
import 'package:plant_match/core/widget/form/form_text_field.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:plant_match/feature/auth/presentation/cubit/auth_state.dart';
import 'package:plant_match/feature/auth/presentation/sign_up/widget/form_sign_up/password_field.dart';
import 'package:plant_match/feature/auth/presentation/verify_email.dart';
import 'package:toastification/toastification.dart';

class FormSignUp extends StatefulWidget {
  const FormSignUp({super.key});

  @override
  State<FormSignUp> createState() => _FormSignUpState();
}

class _FormSignUpState extends State<FormSignUp> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormBuilderState>();

  bool _isPasswordVisible = true;
  bool isChecked = false;

  void onPressedSignUp() {
    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String passwordConfirm = _passwordConfirmController.text;

    final authCubit = context.read<AuthCubit>();

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirm.isNotEmpty &&
        isChecked) {
      authCubit.signUpWithEmailAndPassword(
          email: email, password: password, name: name);
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
    _formKey.currentState?.saveAndValidate() ?? false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
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
              builder: (context) => const VerifyEmail(),
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
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormTextField(
                  name: 'email',
                  label: 'E-mail',
                  controller: _emailController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: false,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Ce champ est requis'),
                    FormBuilderValidators.email(
                        errorText: 'Entrez un e-mail valide'),
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormTextField(
                  name: 'name',
                  label: 'Prénom et nom',
                  validator: FormBuilderValidators.required(
                      errorText: 'Ce champ est requis'),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: false,
                  controller: _nameController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PasswordField(
                  controller: _passwordController,
                  obscureText: _isPasswordVisible,
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormTextField(
                  name: 'passwordConfirm',
                  label: 'Confirmer le mot de passe',
                  controller: _passwordConfirmController,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Ce champ est requis'),
                    (val) {
                      if (val != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FormBuilderField<bool>(
                  name: 'acceptTerms',
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: FormBuilderValidators.compose([
                    (value) {
                      if (value == null || value == false) {
                        return 'Ce champ est requis';
                      }
                      return null;
                    },
                  ]),
                  builder: (FormFieldState<bool?> field) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            errorText:
                                isChecked == false ? field.errorText : null),
                        child: Transform(
                          transform: Matrix4.translationValues(-22, 0.0, 0.0),
                          child: CheckboxField(
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue ?? false;
                              });
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: FilledButton(
                    onPressed: () {
                      onPressedSignUp();
                    },
                    child: const Text("Créer un compte"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Vous avez déjà un compte ? ',
                    style: const TextStyle(
                        color: AppColors.greyDark, fontSize: 11),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        text: 'S\'identifier',
                        style: const TextStyle(
                            color: AppColors.blueGreen,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
