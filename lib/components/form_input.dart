import 'package:flutter/material.dart';
import '../constants.dart';

class FormInput extends StatelessWidget {
  const FormInput(
      {super.key,
      required this.hintText,
      required this.validatorFunction,
      this.obsecure = false,
      required this.onChangedFunction});

  final bool obsecure;
  final Function(String) onChangedFunction;
  final String hintText;
  final String? Function(String?) validatorFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: sizeBoxWidth,
          child: TextFormField(
            onChanged: onChangedFunction,
            obscureText: obsecure,
            decoration: kTextFieldDecoration.copyWith(hintText: hintText),
            validator: validatorFunction,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
