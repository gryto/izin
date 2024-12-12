
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class CustomDropdown {
  static Widget dropdownString(
      {required BuildContext context,
      required String? value,
      required String hint,
      required List<String> items,
      required void Function(String?)? onChanged}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          hint,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).hintColor,
          ),
        ),
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: ColorApp.dark,
            ),
          ),
          // elevation: 2,
        ),
        value: value,
        items: items
            .map((String e) => DropdownMenuItem<String>(
                value: e,
                child: Text(
                  e.toString(),
                )))
            .toList(),
        onChanged: onChanged,
        dropdownStyleData: DropdownStyleData(
          width: 160,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(0, 8),
        ),
      ),
    );
  }

  static Widget dropdown(
      {required String hint,
      required BuildContext context,
      required String textValidator,
      required String label,
      required void Function(String?)? onChanged,
      required List<String> items,
      String? val, String? value}) {
    return FormField<String>(
      validator: (value) {
        if (val == null || val.isEmpty) {
          return textValidator;
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InputDecorator(
              decoration: const InputDecoration(
                border: InputBorder.none,
                // labelText: label,
                // errorText: state.errorText,
              ),
              isEmpty: val == null || val.isEmpty,
              child: DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  hint: Text(
                    hint,
                    style: const TextStyle(
                        fontSize: 12,
                        color: ColorApp.dark//Theme.of(context).hintColor,
                        ),
                  ),
                  value: val,
                  onChanged: onChanged,
                  // (String? newValue) {
                  //   state.didChange(newValue);
                  // },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.only(right: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: ColorApp.dark,
                      ),
                    ),
                    // elevation: 2,
                  ),
                  items: items.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 5.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: ColorApp.dark,
                    fontSize: 12.0,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// ,
// detailJadwalDonorController.listJenisDonor