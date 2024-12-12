import 'package:flutter/material.dart';

import '../../utils/constants/constantStyle.dart';

class InputText extends StatelessWidget {
  const InputText(
      {super.key, required this.controller, this.isPassword = false, required this.icon});
  final TextEditingController controller;
  final bool isPassword;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration:
          ConstantStyle.inputDecorationWithIcon('', icon),
    );
  }
}
