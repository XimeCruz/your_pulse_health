part of 'pressurewatchdevice_bloc.dart';

@immutable
abstract class PressureWatchDeviceState {}

class PressureWatchDeviceInitial extends PressureWatchDeviceState {}

// class CardTappedState extends PressureState {
//   final WorkoutData workout;
//
//   CardTappedState({required this.workout});
// }
//
// class ReloadPressureState extends PressureState {
//   final List<WorkoutData> Pressure;
//
//   ReloadPressureState({
//     required this.Pressure,
//   });
// }

class TypePressureMeasurementState extends PressureWatchDeviceState {
  final List<TypePressureData> typepressures;

  TypePressureMeasurementState({
    required this.typepressures,
  });
}
