part of 'pressure_bloc.dart';

@immutable
abstract class PressureEvent {}

class CardTappedEvent extends PressureEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class PressureInitialEvent extends PressureEvent {}

class GraphEvent extends PressureEvent{}