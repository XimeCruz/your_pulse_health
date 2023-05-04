part of 'tip_bloc.dart';

@immutable
abstract class TipState {}

class TipInitial extends TipState {}

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

class TypePressureMeasurementState extends TipState {
  final List<TypePressureData> typepressures;

  TypePressureMeasurementState({
    required this.typepressures,
  });
}
