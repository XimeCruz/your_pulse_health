part of 'report_bloc.dart';

@immutable
abstract class ReportState {}

class ReportInitial extends ReportState {}

class TypePressureMeasurementState extends ReportState {
  final List<TypePressureData> typepressures;

  TypePressureMeasurementState({
    required this.typepressures,
  });
}

class PressureDataState extends ReportState {
  final List<PressureData> pressuredata;

  PressureDataState({
    required this.pressuredata,
  });
}
