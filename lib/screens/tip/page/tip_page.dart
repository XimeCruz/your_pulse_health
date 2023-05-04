import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/tip/bloc/tip_bloc.dart';
import 'package:your_pulse_health/screens/tip/widget/tip_content.dart';

class TipPage extends StatelessWidget {
  const TipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<TipBloc> _buildContext(BuildContext context) {
    return BlocProvider<TipBloc>(
      create: (BuildContext context) => TipBloc(),
      child: BlocConsumer<TipBloc, TipState>(
        buildWhen: (_, currState) =>
            currState is TipInitial ||
            currState is TypePressureMeasurementState,
        //currState is PressureInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<TipBloc>(context);
          if (state is TipInitial) {
            bloc.add(TipInitialEvent());
            //bloc.add(ReloadDisplayNameEvent());
            //bloc.add(ReloadImageEvent());
          }
          return TipContent(
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
