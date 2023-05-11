import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:your_pulse_health/data/tip_data.dart';
import 'package:meta/meta.dart';

part 'tipdetails_event.dart';
part 'tipdetails_state.dart';

class TipDetailsBloc
    extends Bloc<TipDetailsEvent, TipDetailsState> {
  TipDetailsBloc() : super(TipDetailsInitial());

  late TipData tip;

  @override
  Stream<TipDetailsState> mapEventToState(
      TipDetailsEvent event,
      ) async* {
    if (event is TipDetailsInitialEvent) {
      tip = event.tip;
      yield ReloadTipDetailsState(tip: tip);
    } else if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is StartTappedEvent) {
      yield StartTappedState(
        tip: event.tip ?? tip,
        index: event.index ?? 0,
        isReplace: event.isReplace,
      );
    }
  }
}
