part of 'pressurecamera_bloc.dart';

@immutable
abstract class PressureCameraEvent {}

class CardTappedEvent extends PressureCameraEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}

class PressureCameraInitialEvent extends PressureCameraEvent {}

class GraphEvent extends PressureCameraEvent{}

class ChangeBPMEvent extends PressureCameraEvent{
  late final bool isBPMEnabled;
  ChangeBPMEvent({required this.isBPMEnabled});

}