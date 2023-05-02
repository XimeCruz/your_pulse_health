import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';

part 'pressurecamera_event.dart';
part 'pressurecamera_state.dart';

class PressureCameraBloc extends Bloc<PressureCameraEvent, PressureCameraState> {
  PressureCameraBloc() : super(PressureCameraInitial());
  List<TypePressureData> typePressureCamera = <TypePressureData>[];

  //int timeSent = 0;

  @override
  Stream<PressureCameraState> mapEventToState(
      PressureCameraEvent event,
      ) async* {
    if (event is PressureCameraInitialEvent) {
      typePressureCamera = DataConstants.typepressure;
      yield TypePressureCameraMeasurementState(typepressures: typePressureCamera);
    }
    else if(event is GraphEvent){

    }
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

