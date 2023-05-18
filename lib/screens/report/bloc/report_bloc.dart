import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/service/bpm_service.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';

import 'package:your_pulse_health/data/workout_data.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc(this.bpmService) : super(ReportInitial());
  List<TypePressureData> typepressure = <TypePressureData>[];
  BpmService bpmService;
  //int timeSent = 0;

  @override
  Stream<ReportState> mapEventToState(
    ReportEvent event,
  ) async* {
    if (event is ReportInitialEvent) {
      typepressure = DataConstants.typepressure;
      yield TypePressureMeasurementState(typepressures: typepressure);
    } else if (event is GetPressureEvent) {
      DateTime? dateStart = event.startDate;
      DateTime? dateEnd = event.endDate;

      var list = await bpmService.getBpmPressure(start: dateStart,end: dateEnd);
      print(list.length);


      yield PressureDataState(pressuredata: list);
    }
  }
}
