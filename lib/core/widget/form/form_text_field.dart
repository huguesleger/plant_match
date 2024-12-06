import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:plant_match/core/app_colors.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.name,
    required this.label,
    required this.validator,
    required this.autoValidateMode,
    required this.obscureText,
    required this.controller,
    this.suffixIcon,
    this.helperText,
  });

  final String name;
  final String label;
  final FormFieldValidator<String> validator;
  final AutovalidateMode autoValidateMode;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      autovalidateMode: autoValidateMode,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        helperText: helperText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        suffixIcon: suffixIcon,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: AppColors.blueGreen,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
