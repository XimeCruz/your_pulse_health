import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';

part 'tip_event.dart';
part 'tip_state.dart';

class TipBloc extends Bloc<TipEvent, TipState> {
  TipBloc() : super(TipInitial());
  List<TypePressureData> typepressure = <TypePressureData>[];

  //int timeSent = 0;

  @override
  Stream<TipState> mapEventToState(
    TipEvent event,
  ) async* {
    if (event is TipInitialEvent) {
      typepressure = DataConstants.typepressure;
      yield TypePressureMeasurementState(typepressures: typepressure);
    } else if (event is GraphEvent) {}
    // } else if (event is ReloadImageEvent) {
    //   String? photoURL = await UserStorageService.readSecureData('image');
    //   if (photoURL == null) {
    //     photoURL = AuthService.auth.currentUser?.photoURL;
    //     photoURL != null
    //         ? await UserStorageService.writeSecureData('image', photoURL)
    //         : print('sin imagen de usuario');
    //   }
    //   yield ReloadImageState(photoURL: photoURL);
    // } else if (event is ReloadDisplayNameEvent) {
    //   final displayName = await UserStorageService.readSecureData('name');
    //   yield ReloadDisplayNameState(displayName: displayName);
    // }
  }
}
