import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/workout_details_screen/page/workout_details_page.dart';
import 'package:your_pulse_health/screens/pressure/bloc/pressure_bloc.dart';
import 'package:your_pulse_health/screens/pressure/widget/pressure_content.dart';

class PressurePage extends StatelessWidget {
  const PressurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<PressureBloc> _buildContext(BuildContext context) {
    return BlocProvider<PressureBloc>(
      create: (BuildContext context) => PressureBloc(),
      child: BlocConsumer<PressureBloc, PressureState>(
        buildWhen: (_, currState) =>
        currState is PressureInitial || currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<PressureBloc>(context);
          if (state is PressureInitial) {
            bloc.add(PressureInitialEvent());
            //bloc.add(ReloadDisplayNameEvent());
            //bloc.add(ReloadImageEvent());
          }
          return PressureContent(
            typepressures: bloc.typepressure,
            // traceSine: [],
            // traceCosine: [],
            // radians: 0,);
          );
        },
        listenWhen: (_, currState) => true,
        listener: (context, state) {},
      ),
    );
  }
}