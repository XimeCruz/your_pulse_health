import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/core/service/bpm_service.dart';
import 'package:your_pulse_health/screens/pressure_camera/bloc/pressurecamera_bloc.dart';
import 'package:your_pulse_health/screens/pressure_camera/widget/pressurecamera_content.dart';
import 'package:your_pulse_health/screens/tab_bar/page/tab_bar_page.dart';
import 'package:your_pulse_health/screens/pressure/bloc/pressure_bloc.dart';

class PressureCameraPage extends StatelessWidget {
  const PressureCameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          TextConstants.pressurebycamera,
          style: TextStyle(color: ColorConstants.primaryColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: ColorConstants.primaryColor,
          ),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) => TabBarPage()));
          },
        ),
      ),
    );
  }

  BlocProvider<PressureCameraBloc> _buildContext(BuildContext context) {
    return BlocProvider<PressureCameraBloc>(
      create: (BuildContext context) => PressureCameraBloc(BpmService()),
      child: BlocConsumer<PressureCameraBloc, PressureCameraState>(
        buildWhen: (_, currState) =>
        currState is PressureCameraInitial || currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<PressureCameraBloc>(context);
          if (state is PressureInitial) {
            bloc.add(PressureCameraInitialEvent());
          }
          return PressureCameraContent(
            typepressures: bloc.typePressureCamera,
          );
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}