part of 'record_bloc.dart';

@immutable
abstract class RecordState {}

class RecordInitial extends RecordState {}

class PressureDataState extends RecordState {
  final List<PressureData> pressuredata;

  PressureDataState({
    required this.pressuredata,
  });
}
