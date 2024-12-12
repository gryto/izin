import 'package:flutter/material.dart';
import '../../utils/constants/constantStyle.dart';

class TextFormFoeldActivity extends StatelessWidget {
  final String title;
  final bool readOnly;
  final bool enable;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final VoidCallback onClick;
  final ValueChanged<String>? onChanged;

  const TextFormFoeldActivity({
    Key? key,
    required this.title,
    required this.readOnly,
    required this.enable,
    required this.focusNode,
    required this.controller,
    required this.onClick,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      // key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              maxLines: title == 'Deskripsi' ? 3 : null   ,
                onChanged: onChanged,
                enabled: enable,
                readOnly: readOnly,
                focusNode: focusNode,
                controller: controller,
                // key: _formKey,
                decoration: 
                ConstantStyle.inputDecorationDefault( title),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pilih $title Terlebih Dahulu!';
                  }
                  return null;
                },
                onTap: onClick),
          ],
        ),
      ),
    );
  }
}
