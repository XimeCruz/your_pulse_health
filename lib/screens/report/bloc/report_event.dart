part of 'report_bloc.dart';

@immutable
abstract class ReportEvent {}

class CardTappedEvent extends ReportEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class ReportInitialEvent extends ReportEvent {}

class GraphEvent extends ReportEvent {}
