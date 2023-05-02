import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/core/service/data_service.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';
import 'dart:math';

part 'pressurewatchdevice_event.dart';
part 'pressurewatchdevice_state.dart';

class PressureWatchDeviceBloc
    extends Bloc<PressureWatchDeviceEvent, PressureWatchDeviceState> {
  PressureWatchDeviceBloc() : super(PressureWatchDeviceInitial());
  List<TypePressureData> typepressure = <TypePressureData>[];

  //int timeSent = 0;

  @override
  Stream<PressureWatchDeviceState> mapEventToState(
    PressureWatchDeviceEvent event,
  ) async* {
    if (event is PressureWatchDeviceInitialEvent) {
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
