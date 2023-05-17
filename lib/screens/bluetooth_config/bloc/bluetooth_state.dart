part of 'bluetooth_bloc.dart';

@immutable
abstract class BluetoothServiceState {}

class BluetoothInitial extends BluetoothServiceState {}

class GraphState extends BluetoothServiceState{
  List<double> traceSine = [];
  List<double> traceCosine = [];
  double radians = 0.0;
  Timer? timer;

  GraphState({
    required this.traceCosine,
    required this.traceSine,
    required this.radians,
    required this.timer,
  });
}

class ChangeBPMState extends BluetoothServiceState{
  late bool isBPMEnabled;
  ChangeBPMState({
    required this.isBPMEnabled
  });
}


