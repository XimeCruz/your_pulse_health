import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/tip_details_screen/bloc/tipdetails_bloc.dart';

class TipDetailsBody extends StatelessWidget {
  final TipData tip;
  TipDetailsBody({required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    final bloc = BlocProvider.of<TipDetailsBloc>(context);
    return Positioned(
      child: SafeArea(
        child: BlocBuilder<TipDetailsBloc, TipDetailsState>(
          builder: (context, state) {
            return GestureDetector(
              child: Container(
                width: 30,
                height: 30,
                child: Image(
                  image: AssetImage(PathConstants.back),
                ),
              ),
              onTap: () {
                bloc.add(BackTappedEvent());
              },
            );
          },
        ),
      ),
      left: 20,
      top: 14,
    );
  }

  Widget _createImage() {
    return Container(
      width: double.infinity,
      height: 350,
      child: Image(
        image: AssetImage(tip.image ?? ""),
        fit: BoxFit.cover,
      ),
    );
  }
}
