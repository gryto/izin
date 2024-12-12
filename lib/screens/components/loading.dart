import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/constants/colors.dart';

Widget cLoading() {
    return const SpinKitThreeBounce(
      color: ColorApp.dark,
      size: 20,
    );
  }