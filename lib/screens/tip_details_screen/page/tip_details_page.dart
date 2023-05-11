import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:your_pulse_health/screens/common_widgets/pulse_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/screens/tip_details_screen/bloc/tipdetails_bloc.dart';
import 'package:your_pulse_health/screens/tip_details_screen/widget/tip_details_content.dart';

class TipDetailsPage extends StatelessWidget {

  final TipData tip;

  TipDetailsPage({required this.tip});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<TipDetailsBloc> _buildContext(BuildContext context) {
    final tipDetailsBloc = TipDetailsBloc();
    return BlocProvider<TipDetailsBloc>(
      create: (context) => tipDetailsBloc,
      child: BlocConsumer<TipDetailsBloc, TipDetailsState>(
        buildWhen: (_, currState) => currState is TipDetailsInitial,
        builder: (context, state) {
          final bloc = BlocProvider.of<TipDetailsBloc>(context);
          bloc.add(TipDetailsInitialEvent(tip: tip));
          return Scaffold(
              // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              // floatingActionButton: Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   child: SizedBox(width: 0,),
              //
              // ),
              body: TipDetailsContent(tip: tip)
          );
        },
        listenWhen: (_, currState) =>
            currState is BackTappedState ||
            currState is TipExerciseCellTappedState ||
            currState is StartTappedState,
        listener: (context, state) async {
          if (state is BackTappedState) {
            Navigator.pop(context);
          } else if (state is StartTappedState) {
            // final tip = state.isReplace
            //     ? await Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (_) => BlocProvider.value(
            //       value: BlocProvider.of<TipDetailsBloc>(context),
            //       child: StartTipPage(
            //         tip: state.tip,
            //         index: state.index,
            //       ),
            //     ),
            //   ),
            // )
            //     : await Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => BlocProvider.value(
            //       value: BlocProvider.of<TipDetailsBloc>(context),
            //       child: StartTipPage(
            //         tip: state.tip,
            //         index: state.index,
            //       ),
            //     ),
            //   ),
            // );
            // if (tip is TipData) {
            //   BlocProvider.of<TipDetailsBloc>(context).add(
            //     TipDetailsInitialEvent(tip: tip),
            //   );
            // }
          }
        },
      ),
    );
  }
}
