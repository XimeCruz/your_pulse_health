import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/pressure_watch_device/bloc/pressurewatchdevice_bloc.dart';
import 'package:your_pulse_health/screens/pressure_watch_device/widget/pressurewatchdevice_content.dart';

class PressureWatchDevicePage extends StatelessWidget {
  const PressureWatchDevicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<PressureWatchDeviceBloc> _buildContext(BuildContext context) {
    return BlocProvider<PressureWatchDeviceBloc>(
      create: (BuildContext context) => PressureWatchDeviceBloc(),
      child: BlocConsumer<PressureWatchDeviceBloc, PressureWatchDeviceState>(
        buildWhen: (_, currState) =>
            currState is PressureWatchDeviceInitial ||
            currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<PressureWatchDeviceBloc>(context);
          if (state is PressureWatchDeviceInitial) {
            bloc.add(PressureWatchDeviceInitialEvent());
            //bloc.add(ReloadDisplayNameEvent());
            //bloc.add(ReloadImageEvent());
          }
          return PressureWatchDeviceContent(
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
