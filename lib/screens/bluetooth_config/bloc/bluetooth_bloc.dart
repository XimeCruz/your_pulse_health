import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/core/service/bpm_service.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';

part 'bluetooth_event.dart';
part 'bluetooth_state.dart';

class BluetoothBloc extends Bloc<BluetoothEvent, BluetoothServiceState> {
  BluetoothBloc(
      this.bpmService
      ) : super(BluetoothInitial());

  List<TypePressureData> typePressureCamera = <TypePressureData>[];
  BpmService bpmService;

  //int timeSent = 0;

  @override
  Stream<BluetoothServiceState> mapEventToState(
      BluetoothEvent event,
      ) async* {
    if (event is BluetoothInitialEvent) {
      //typePressureCamera = DataConstants.typepressure;
      //yield TypePressureCameraMeasurementState(typepressures: typePressureCamera);
    }
    else if(event is ChangeBPMEvent){
      yield ChangeBPMState(isBPMEnabled: !event.isBPMEnabled);
    }
    else if(event is SaveBpmEvent){

      String statusNew ='';
      if (event.pressureBpm >=60 && event.pressureBpm <=100){
        statusNew ='Normal';
      }
      else if(event.pressureBpm > 100 || event.pressureBpm < 60){
        statusNew ='Arritmia';
      }
      PressureData pressureData = PressureData(id: '', userId: GlobalConstants.currentUser.uuid,date: DateTime.now(), bpm: event.pressureBpm, status: statusNew);
      print(pressureData.toString());
      await bpmService.saveBpmPressure(pressureData);
    }
  }

}



