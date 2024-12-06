import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:plant_match/core/app_colors.dart';
import 'package:plant_match/core/widget/form/form_text_field.dart';

class FormForgotPassword extends StatefulWidget {
  const FormForgotPassword({super.key});

  @override
  State<FormForgotPassword> createState() => _FormForgotPasswordState();
}

class _FormForgotPasswordState extends State<FormForgotPassword> {
  final _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                child: const Text("Envoyer"),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.greyLight),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Annuler',
                  style: TextStyle(
                    color: AppColors.blueGreen,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
