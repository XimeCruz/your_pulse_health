part of 'pressure_bloc.dart';

@immutable
abstract class PressureState {}

class PressureInitial extends PressureState {}

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

class TypePressureMeasurementState extends PressureState{
  final List<TypePressureData> typepressures;

  TypePressureMeasurementState({
    required this.typepressures,
  });
}

class GraphState extends PressureState{
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
