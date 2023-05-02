part of 'pressurewatchdevice_bloc.dart';

@immutable
abstract class PressureWatchDeviceEvent {}

class CardTappedEvent extends PressureWatchDeviceEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class PressureWatchDeviceInitialEvent extends PressureWatchDeviceEvent {}

class GraphEvent extends PressureWatchDeviceEvent {}
