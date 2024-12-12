import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'constants/colors.dart';

class WidgetSupport {


  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(String text, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 200,
          right: 20,
          left: 20),
    ));
  }

  static dialogNoInternet(BuildContext context) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Warning',
      desc: 'No Internet Connection',
    ).show();
  }
}
