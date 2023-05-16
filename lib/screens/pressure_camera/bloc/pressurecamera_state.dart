part of 'pressurecamera_bloc.dart';

@immutable
abstract class PressureCameraState {}

class PressureCameraInitial extends PressureCameraState {}

// class CardTappedState extends PressureCameraState {
//   final WorkoutData workout;
//
//   CardTappedState({required this.workout});
// }
//
// class ReloadPressureCameraState extends PressureCameraState {
//   final List<WorkoutData> Pressure;
//
//   ReloadPressureCameraState({
//     required this.Pressure,
//   });
// }

class TypePressureCameraMeasurementState extends PressureCameraState{
  final List<TypePressureData> typepressures;

  TypePressureCameraMeasurementState({
    required this.typepressures,
  });
}

class GraphState extends PressureCameraState{
  List<double> traceSine = [];
  List<double> traceCosine = [];
  double radians = 0.0;
  Timer? timer;

  GraphState({
    required this.traceCosine,
    required this.traceSine,
    required this.radians,
    required this.timer,
  });
}

class ChangeBPMState extends PressureCameraState{
  late bool isBPMEnabled;
  ChangeBPMState({
    required this.isBPMEnabled
  });
}


