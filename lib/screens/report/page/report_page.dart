import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/report/bloc/report_bloc.dart';
import 'package:your_pulse_health/screens/report/widget/report_content.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<ReportBloc> _buildContext(BuildContext context) {
    return BlocProvider<ReportBloc>(
      create: (BuildContext context) => ReportBloc(),
      child: BlocConsumer<ReportBloc, ReportState>(
        buildWhen: (_, currState) =>
            currState is ReportInitial ||
            currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<ReportBloc>(context);
          if (state is ReportInitial) {
            bloc.add(ReportInitialEvent());
            //bloc.add(ReloadDisplayNameEvent());
            //bloc.add(ReloadImageEvent());
          }
          return ReportContent(
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
