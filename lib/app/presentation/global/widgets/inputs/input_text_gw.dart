import 'package:flutter/material.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';

class InputTextGW extends StatelessWidget {
  const InputTextGW({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.validator,
  });
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText ?? 'Enter text',
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: const OutlineInputBorder(),
      ),
    ).padding(const EdgeInsets.symmetric(vertical: 8.0));
  }
}
