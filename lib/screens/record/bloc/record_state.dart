part of 'record_bloc.dart';

@immutable
abstract class RecordState {}

class RecordInitial extends RecordState {}

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

class TypePressureMeasurementState extends RecordState {
  final List<TypePressureData> typepressures;

  TypePressureMeasurementState({
    required this.typepressures,
  });
}
