import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/record/bloc/record_bloc.dart';
import 'package:your_pulse_health/screens/record/widget/record_content.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<RecordBloc> _buildContext(BuildContext context) {
    return BlocProvider<RecordBloc>(
      create: (BuildContext context) => RecordBloc(),
      child: BlocConsumer<RecordBloc, RecordState>(
        buildWhen: (_, currState) =>
            currState is RecordInitial ||
            currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<RecordBloc>(context);
          if (state is RecordInitial) {
            bloc.add(RecordInitialEvent());
            //bloc.add(ReloadDisplayNameEvent());
            //bloc.add(ReloadImageEvent());
          }
          return RecordContent(
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
