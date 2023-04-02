import 'package:dwaste/models/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFields extends StatelessWidget {
  const AppTextFields({
    super.key,
    required this.text,
    this.icon,
    this.hintText,
    this.validator,
    required this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    required this.controller,
    this.textCapitalization = TextCapitalization.none,
  });
  final String text;
  final icon;
  final hintText;
  final validator;
  final keyboardType;
  final onChanged;
  final bool obscureText;
  final TextEditingController controller;
  final textCapitalization;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        text == ''
            ? const SizedBox(
                height: 0,
              )
            : Text(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
        const SizedBox(
          height: 12.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff848484)),
                borderRadius: BorderRadius.circular(40.0)
                //  when the TextFormField in unfocused
                ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffDDDDDD)),
                borderRadius: BorderRadius.circular(40.0)
                //  when the TextFormField in unfocused
                ),
            hintText: hintText,
            hintStyle: text == ''
                ? const TextStyle(color: Colors.black38)
                : const TextStyle(color: Colors.black12),
            suffixIcon: icon == "" ? Container() : icon,
            suffixIconColor: AppColors.grey,
            contentPadding: const EdgeInsets.only(top: 35.0, left: 20.0),
          ),
          validator: validator,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
        ),
        const SizedBox(
          height: 15.0,
        )
      ],
    );
  }
}
