import 'package:flutter/material.dart';

import 'colors.dart';
// import 'package:form_field_validator/form_field_validator.dart';

class ConstantStyle {
  static const spaceUpS = SizedBox(
    height: 5,
  );
  static const spaceUpM = SizedBox(
    height: 15,
  );
  static const spaceUpL = SizedBox(
    height: 20,
  );
  static const spaceUpXL = SizedBox(
    height: 25,
  );

  static const spaceUpXXL = SizedBox(
    height: 50,
  );

  static const spaceSideS = SizedBox(
    width: 5,
  );
  static const spaceSideM = SizedBox(
    width: 15,
  );
  static const spaceSideL = SizedBox(
    width: 20,
  );
  static const spaceSideXL = SizedBox(
    width: 25,
  );

  static const spaceSideXXL = SizedBox(
    width: 50,
  );

  //Style Text
  static const textS = TextStyle(fontSize: 10, color: ColorApp.dark);
  static const textSB = TextStyle(
      fontSize: 10, fontWeight: FontWeight.bold, color: ColorApp.dark);
  static const textM = TextStyle(fontSize: 12, color: ColorApp.dark);
  static const textMB = TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: ColorApp.dark);
  static const textL = TextStyle(fontSize: 16, color: ColorApp.dark);
  static const textLB = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: ColorApp.dark);
  static const textXL = TextStyle(fontSize: 20, color: ColorApp.dark);
  static const textXLB = TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: ColorApp.dark);

  //Style
  static final borderFormInput = OutlineInputBorder(
    borderSide: const BorderSide(
      color: ColorApp.dark,
      width: 1.0,
    ),
    borderRadius: BorderRadius.circular(10.0),
  );

  static final borderFormInputFocus = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(color: ColorApp.dark, width: 2.0),
  );

  static InputDecoration inputDecorationWithIcon(String text, IconData icon) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      labelText: text,
      prefixIcon: Icon(
        icon,
        color: ColorApp.dark,
      ),
      labelStyle: const TextStyle(fontSize: 15, color: ColorApp.dark),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorApp.dark),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: ColorApp.dark),
          borderRadius: BorderRadius.circular(10)),
    );
    // InputDecoration(
    //   filled: true,
    //   // fillColor: ColorApp.backgroundColor,
    //   prefixIcon: Icon(
    //     icon,
    //     color: ColorApp.dark,
    //   ),
    //   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //   hintText: text,
    //   labelStyle: TextStyle(color: Colors.red),
    //   border: OutlineInputBorder(
    //     borderSide: BorderSide(width: 20),
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   enabledBorder: ConstantStyle.borderFormInput,
    //   focusedBorder: ConstantStyle.borderFormInputFocus,
    // );
  }

  static InputDecoration inputDecoration(String text) {
    return InputDecoration(
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      labelText: text,
      labelStyle: const TextStyle(fontSize: 15, color: ColorApp.dark),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorApp.dark),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: ColorApp.dark),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  static InputDecoration inputDecorationWithErrorText(
      String text, String? errorText) {
    return InputDecoration(
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      labelText: text,
      labelStyle: const TextStyle(fontSize: 15, color: Colors.black),

      // errorText: errorText,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorApp.dark),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: ColorApp.dark),
          borderRadius: BorderRadius.circular(5)),
    );
  }

  static BoxShadow shadow = BoxShadow(
    color: Colors.grey.shade300,
    blurRadius: 3,
    spreadRadius: 0.2,
    offset: const Offset(2, 3),
  );

  // static LinearGradient colorGradientfttb = const LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [
  //     ColorApp.base,
  //     ColorApp.basePrimary,
  //   ],
  // );
  // static LinearGradient colorGradientfbtt = const LinearGradient(
  //   begin: Alignment.bottomCenter,
  //   end: Alignment.topCenter,
  //   colors: [
  //     ColorApp.base,
  //     ColorApp.backgroundColor,
  //   ],
  // );

  // static RequiredValidator requiredValidator =
  //     RequiredValidator(errorText: 'harus diisi');

  static BoxDecoration background = const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/background.png'),
      fit: BoxFit.fill,
    ),
  );

  static BoxDecoration bottomSheetDecor = const BoxDecoration(
      color: Color.fromARGB(255, 129, 176, 134),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));

  static Widget strip = Container(
    height: 5,
    width: 40,
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 103, 102, 99),
        borderRadius: BorderRadius.circular(50)),
  );

  static InputDecoration inputDecorationDefault(String text) {
    return InputDecoration(

      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      labelText: text,
      labelStyle: const TextStyle(fontSize: 12, color: ColorApp.basic),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorApp.basic),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: ColorApp.button),
          borderRadius: BorderRadius.circular(10)),
      // fillColor: ColorApp.appBar,
      // filled: true,
      // prefixStyle: const TextStyle(color: Colors.yellow),
    );
  }

  //   static InputDecoration inputDecorationDefault(String text) {
  //   return InputDecoration(
  //     counterText: '',
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //     labelText: text,
  //     labelStyle: const TextStyle(fontSize: 12, color: ColorApp.basic),
  //     enabledBorder: OutlineInputBorder(
  //         borderSide: const BorderSide(color: ColorApp.basic),
  //         borderRadius: BorderRadius.circular(20)),
  //     focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(width: 2.0, color: ColorApp.button),
  //         borderRadius: BorderRadius.circular(10)),
  //     // fillColor: ColorApp.appBar,
  //     // filled: true,
  //     // prefixStyle: const TextStyle(color: Colors.yellow),
  //   );
  // }

  static InputDecoration inputDecorationNoLabel() {
    return InputDecoration(
      counterText: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorApp.light),
          borderRadius: BorderRadius.circular(20)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: ColorApp.light),
          borderRadius: BorderRadius.circular(10)),
      // fillColor: ColorApp.appBar,
      // filled: true,
      // prefixStyle: const TextStyle(color: Colors.yellow),
    );
  }
}
