part of 'report_bloc.dart';

@immutable
abstract class ReportEvent {}

class CardTappedEvent extends ReportEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class ReportInitialEvent extends ReportEvent {}

class GraphEvent extends ReportEvent {}

class GetPressureEvent extends ReportEvent{

  final DateTime? startDate;
  final DateTime? endDate;

  GetPressureEvent({this.startDate,this.endDate});

}