part of 'tip_bloc.dart';

@immutable
abstract class TipEvent {}

class CardTappedEvent extends TipEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class TipInitialEvent extends TipEvent {}

class GraphEvent extends TipEvent {}
