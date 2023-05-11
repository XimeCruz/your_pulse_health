import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:your_pulse_health/screens/tip_details_screen/widget/panel/tip_details_panel.dart';
import 'package:your_pulse_health/screens/tip_details_screen/widget/tip_details_body.dart';

class TipDetailsContent extends StatelessWidget {
  final TipData tip;

  const TipDetailsContent({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: _createSlidingUpPanel(context),
    );
  }

  Widget _createSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      panel: TipDetailsPanel(tip: tip),
      body: TipDetailsBody(tip: tip),
      minHeight: MediaQuery.of(context).size.height * 0.65,
      maxHeight: MediaQuery.of(context).size.height * 0.87,
      isDraggable: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    );
  }
}
