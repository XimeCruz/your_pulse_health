import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';

class PulseLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: ColorConstants.loadingBlack,
      child: Center(
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme:
                CupertinoThemeData(brightness: Brightness.dark),
          ),
          child: CupertinoActivityIndicator(
            radius: 17,
          ),
        ),
      ),
    );
  }
}