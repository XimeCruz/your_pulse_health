import 'package:flutter/material.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';

class PressureButton extends StatelessWidget {
  final String title;
  final IconData name;
  final Function() onTap;

  PressureButton({required this.title, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {

    return new SizedBox(
      width: double.infinity,
      child:
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: ColorConstants.primaryColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Icon( // <-- Icon
              name,
              size: 24.0,
            ),
            const SizedBox(height: 5),
            Text(
              title ?? "",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ],
        ),
        onPressed: onTap,
      ),
    );
  }
}
