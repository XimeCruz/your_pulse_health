part of 'record_bloc.dart';

@immutable
abstract class RecordEvent {}

class CardTappedEvent extends RecordEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class RecordInitialEvent extends RecordEvent {}

class GraphEvent extends RecordEvent {}

enum DateFilter{semana,mes,trimestre}

class GetPressureEvent extends RecordEvent{
  final DateFilter? filterDate;

  GetPressureEvent({this.filterDate});
}
