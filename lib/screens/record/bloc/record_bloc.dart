import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/service/bpm_service.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/data/workout_data.dart';

part 'record_event.dart';
part 'record_state.dart';

class RecordBloc extends Bloc<RecordEvent, RecordState> {
  RecordBloc(this.bpmService) : super(RecordInitial());
  List<TypePressureData> typepressure = <TypePressureData>[];
  BpmService bpmService;
  //int timeSent = 0;

  @override
  Stream<RecordState> mapEventToState(
    RecordEvent event,
  ) async* {
    if (event is RecordInitialEvent) {
      typepressure = DataConstants.typepressure;
      //yield TypePressureMeasurementState(typepressures: typepressure);
    } else if (event is GetPressureEvent) {
      DateTime? dateStart;
      DateTime? dateEnd;

      DateTime today = DateTime.now();
      if(event.filterDate!=null){
        switch(event.filterDate){
          case DateFilter.semana:
            //dateStart = DateTime
            break;
          case DateFilter.mes:
            // TODO: Handle this case.
            break;
          case DateFilter.trimestre:
            // TODO: Handle this case.
            break;
        }
      }

      var list = await bpmService.getBpmPressure(start: dateStart,end: dateEnd);
      print(list);

      yield PressureDataState(pressuredata: list);
    }
  }
}
