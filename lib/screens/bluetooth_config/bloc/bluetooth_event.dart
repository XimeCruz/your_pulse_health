part of 'bluetooth_bloc.dart';

@immutable
abstract class BluetoothEvent {}

class BluetoothInitialEvent extends BluetoothEvent {}

class GraphEvent extends BluetoothEvent{}

class ChangeBPMEvent extends BluetoothEvent{
  late final bool isBPMEnabled;
  ChangeBPMEvent({required this.isBPMEnabled});

}

class SaveBpmEvent extends BluetoothEvent{
  final int pressureBpm;
  SaveBpmEvent({required this.pressureBpm});
}