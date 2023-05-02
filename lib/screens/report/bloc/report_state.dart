part of 'report_bloc.dart';

@immutable
abstract class ReportState {}

class ReportInitial extends ReportState {}

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

class TypePressureMeasurementState extends ReportState {
  final List<TypePressureData> typepressures;

  TypePressureMeasurementState({
    required this.typepressures,
  });
}
