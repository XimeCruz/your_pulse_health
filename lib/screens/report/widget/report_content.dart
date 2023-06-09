import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/global_constants.dart';
import 'package:your_pulse_health/core/service/pdf_service.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:your_pulse_health/screens/report/bloc/report_bloc.dart';

//class ReportContent extends StatelessWidget {
class ReportContent extends StatefulWidget {
  final List<PressureData> pressureData;
  // final String? startDate;
  // final String? endDate;
  //final FormatPDF? formatPDF;

  ReportContent({
    required this.pressureData,
    Key? key,
  });

  @override
  State<ReportContent> createState() => _ReportContentState();

}

  class _ReportContentState extends State<ReportContent> {
    int valuestatebpm = 60;

    String txtDateStart = '';

    String txtDateEnd = '';


    ///declarar variables de variantes de dia

    num globalMax = 0;
    num globalMin = 0;
    int globalProm = 0;

    num morningMax = 0;
    num morningMin = 0;
    int morningProm = 0;

    num afternoonMax = 0;
    num afternoonMin = 0;
    int afternoonProm = 0;

    num nightMax = 0;
    num nightMin = 0;
    int nightProm = 0;

    num earlyMax = 0;
    num earlyMin = 0;
    int earlyProm = 0;


    @override
    void initState() {
      DateTime date = DateTime.now();
      int day = date.day;
      List<String> months = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
      String month = months[((DateTime.now()).month)-1];

      late DateTime before = date.subtract(const Duration(days: 7));

      late int dayBefore = before.day;
      late String monthBefore = months[before.month-1];

      // txtDateStart = widget.startDate!;
      txtDateStart = '$monthBefore $dayBefore';
      // txtDateEnd = widget.endDate!;
      txtDateEnd = '$month $day';

      globalMax = _getMaxPressureData('G');
      globalMin = _getMinPressureData('G');
      globalProm = _getPromPressureData('G').toInt();

      morningMax = _getMaxPressureData('M');
      morningMin = _getMinPressureData('M');
      morningProm = _getPromPressureData('M').toInt();

      afternoonMax = _getMaxPressureData('T');
      afternoonMin = _getMinPressureData('T');
      afternoonProm = _getPromPressureData('T').toInt();

      nightMax = _getMaxPressureData('N');
      nightMin = _getMinPressureData('N');
      nightProm = _getPromPressureData('N').toInt();

      earlyMax = _getMaxPressureData('MA');
      earlyMin = _getMinPressureData('MA');
      earlyProm = _getPromPressureData('MA').toInt();

      setState(() {

      });

      super.initState();
    }


    @override
    Widget build(BuildContext context) {
        return Container(
        color: ColorConstants.homeBackgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: _createReportBody(context),
        );
    }

    Widget _createReportBody(BuildContext context) {
    final bloc = BlocProvider.of<ReportBloc>(context);
    //required en page con desconte


      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 15,),
          //_downloadDocument(context),
          _rectangleDate(context),
          Container(
            height: 690,
            child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
            _globalPressure(context),
            _morningPressure(context),
            _afternoonPressure(context),
            _nightPressure(context),
            _earlyMorningPressure(context)
            ],
            ),
          ),
          ]
        ),
      );
    }

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      print(args);
      print(DateFormat('dd/MM/yyyy').format(args.value.startDate).toString());
      print(DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)
          .toString());

      DateTime startDay = args.value.startDate;

      final day = startDay.day;
      final months = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
      final month = months[startDay.month-1];

      final before = args.value.endDate ?? args.value.startDate;

      final dayBefore = before.day;
      final monthBefore = months[before.month-1];

      txtDateStart = '$month $day';
      txtDateEnd = '$monthBefore $dayBefore';

      print("object"+txtDateStart);

      // FormatPDF? formatPDF = widget.formatPDF;
      // formatPDF?.dateStart = txtDateStart;
      // formatPDF?.dateEnd = txtDateEnd;


      //seterar los cuatro de varianters tiempo

      globalMax = _getMaxPressureData('G');
      globalMin = _getMinPressureData('G');
      globalProm = _getPromPressureData('G').toInt();

      morningMax = _getMaxPressureData('M');
      morningMin = _getMinPressureData('M');
      morningProm = _getPromPressureData('M').toInt();

      afternoonMax = _getMaxPressureData('T');
      afternoonMin = _getMinPressureData('T');
      afternoonProm = _getPromPressureData('T').toInt();

      nightMax = _getMaxPressureData('N');
      nightMin = _getMinPressureData('N');
      nightProm = _getPromPressureData('N').toInt();

      earlyMax = _getMaxPressureData('MA');
      earlyMin = _getMinPressureData('MA');
      earlyProm = _getPromPressureData('MA').toInt();

      BlocProvider.of<ReportBloc>(context).add(GetPressureEvent(startDate: args.value.startDate, endDate: args.value.endDate ?? args.value.startDate));

      setState(() {

      });


    }

    Widget containerCalendar(BuildContext context) {
      return Container(
        width: 120,
        height: 220,
        child: SfDateRangePicker(
          onSelectionChanged: _onSelectionChanged,
          view: DateRangePickerView.month,
          monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
          selectionMode: DateRangePickerSelectionMode.range,
        ),
      );
    }

    Widget _showAlertDialog(BuildContext context) {

      return AlertDialog(
        title: const Text('Selecciona el rango de fecha'),
        content: containerCalendar(context),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('Seleccionar'),
          ),
        ],
      );

    }

    Widget _downloadDocument(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.download,
            size: 40,
            color: ColorConstants.primaryColor,
          ),
          SizedBox(width: 35,)
        ],
      );
    }

    Widget _rectangleDate(BuildContext context){
      return Row(
        children: [
          SizedBox(width: 20,),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(15)
            ),
            //color: Colors.lightBlue,
            child: Text(
                '$txtDateStart - $txtDateEnd',
                style: TextStyle(
                    fontSize: 20,
                    color: ColorConstants.white
                )
            ),
          ),
          SizedBox(width: 20,),
          TextButton(
            child: const Icon(
                Icons.calendar_today_rounded,
                size: 35,
                color: ColorConstants.primaryColor
            ),
            onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => _showAlertDialog(context)
            ),
          ),
          SizedBox(width: 20,),
          TextButton(
            child: Icon(
              Icons.download,
              size: 40,
              color: ColorConstants.primaryColor,
            ),
            onPressed: ()
              async {
                print(txtDateStart);
                FormatPDF format = FormatPDF(GlobalConstants.currentUser.name!, txtDateStart, txtDateEnd, 10,globalMin,globalProm,0,0,0,0,0,0,0,0,0,0,0,0);
                final data = await PdfReportService().createPdf(format);
                PdfReportService().savePdfFile("Reporte BPM ${DateTime.now()} ${GlobalConstants.currentUser.name}", data);
              },
          ),

          // TextButton(
          //   child: const Icon(
          //       Icons.arrow_back_ios,
          //       size: 35,
          //       color: ColorConstants.primaryColor
          //   ),
          //   onPressed: () {},
          // ),
          // TextButton(
          //   child: const Icon(
          //       Icons.arrow_forward_ios,
          //       size: 35,
          //       color: ColorConstants.primaryColor
          //   ),
          //   onPressed: () {},
          // ),
        ],

      );
    }

    Widget _globalPressure(BuildContext context){

      return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
              width: double.infinity,
              height: 170,
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Global"),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Min',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Prom',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                              Text('Pulso')),
                          DataCell(
                            Text(globalMax.toString()),
                          ),
                          DataCell(
                              Text(globalMin.toString())
                          ),
                          DataCell(
                              Text(globalProm.toString())
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )
          )
      );
    }

    Widget _morningPressure(BuildContext context){

      return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
              width: double.infinity,
              height: 170,
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Mañana (06-12)"),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Min',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Prom',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                              Text('Pulso')),
                          DataCell(
                            Text(morningMax.toString()),
                          ),
                          DataCell(Text(morningMin.toString())),
                          DataCell(Text(morningProm.toString())),
                        ],
                      ),
                    ],
                  )
                ],
              )
          )
      );
    }

    Widget _afternoonPressure(BuildContext context){

      return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
              width: double.infinity,
              height: 170,
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Tarde (12-18)"),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Min',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Prom',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                              Text('Pulso')),
                          DataCell(
                            Text(afternoonMax.toString()),
                          ),
                          DataCell(Text(afternoonMin.toString())),
                          DataCell(Text(afternoonProm.toString())),
                        ],
                      ),
                    ],
                  )
                ],
              )
          )
      );
    }

    Widget _nightPressure(BuildContext context){


      return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
              width: double.infinity,
              height: 170,
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Noche (18-00)"),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Min',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Prom',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                              Text('Pulso')),
                          DataCell(
                            Text(nightMax.toString()),
                          ),
                          DataCell(Text(nightMin.toString())),
                          DataCell(Text(nightMax.toString())),
                        ],
                      ),
                    ],
                  )
                ],
              )
          )
      );
    }

    Widget _earlyMorningPressure(BuildContext context){


      return Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Container(
              width: double.infinity,
              height: 170,
              padding: new EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Madrugada (00-06)"),
                  DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            '',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Max',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Min',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Prom',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: <DataRow>[
                      DataRow(
                        cells: <DataCell>[
                          DataCell(
                              Text('Pulso')),
                          DataCell(
                            Text(earlyMax.toString()),
                          ),
                          DataCell(Text(earlyMin.toString())),
                          DataCell(Text(earlyProm.toString())),
                        ],
                      ),
                    ],
                  )
                ],
              )
          )
      );
    }

    num _getMaxPressureData(String type){
      List<PressureData> list = widget.pressureData;

      List<num> listBpm = [];

      // for (int i = 0; i < list.length; i++) {
      //   listBpm.add(list[i].bpm!);
      // }

      if(type!=null){
        switch(type){
          case 'G':
            for (int i = 0; i < list.length; i++) {
              listBpm.add(list[i].bpm!);
            }
            break;
          case 'D':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour >= 6 && list[i].date!.hour <= 12){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'T':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 12 && list[i].date!.hour <= 18){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'N':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 18 && list[i].date!.hour <= 24){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'MA':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 24 && list[i].date!.hour <= 5){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
        }
      }

      num bpmMayor = 0;
      for (var i = 0; i < listBpm.length; i++) {
        if (listBpm[i] > bpmMayor) {
          bpmMayor = listBpm[i];
        }
      }

      return bpmMayor;
    }

    num _getMinPressureData(String type){

      List<PressureData> list = widget.pressureData;
      List<num> listBpm = [];

      if(type!=null){
        switch(type){
          case 'G':
            for (int i = 0; i < list.length; i++) {
              listBpm.add(list[i].bpm!);
            }
            break;
          case 'D':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour >= 6 && list[i].date!.hour <= 12){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'T':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 12 && list[i].date!.hour <= 18){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'N':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 18 && list[i].date!.hour <= 24){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'MA':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 24 && list[i].date!.hour <= 5){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
        }
      }

      num bpmMin = 0;
      if(listBpm.length != 0){
        bpmMin = listBpm[0];
      }

      for (var i = 0; i < listBpm.length; i++) {
        if (listBpm[i] < bpmMin) {
          bpmMin = listBpm[i];
        }
      }

      return bpmMin;
    }

    num _getPromPressureData(String type){

      List<PressureData> list = widget.pressureData;
      List<num> listBpm = [];

      if(type!=null){
        switch(type){
          case 'G':
            for (int i = 0; i < list.length; i++) {
              listBpm.add(list[i].bpm!);
            }
            break;
          case 'D':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour >= 6 && list[i].date!.hour <= 12){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'T':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 12 && list[i].date!.hour <= 18){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'N':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 18 && list[i].date!.hour <= 24){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
          case 'MA':
            for (int i = 0; i < list.length; i++) {
              if(list[i].date!.hour > 24 && list[i].date!.hour <= 5){
                listBpm.add(list[i].bpm!);
              }
            }
            break;
        }
      }
      num bpmProm = 0;
      num bpmTotal = 0;
      num cantBpm = listBpm.length;

      for (var i = 0; i < listBpm.length; i++) {
        bpmTotal = bpmTotal + listBpm[i];
      }

      if(bpmTotal != 0){
        bpmProm = (bpmTotal/cantBpm);
      }

      return bpmProm;
    }
  }

  class FormatPDF {
    String nombrePaciente;
    String dateStart;
    String dateEnd;

    num globalMax;
    num globalMin;
    num globalProm;

    num morningMax;
    num morningMin;
    num morningProm;

    num afternoonMax;
    num afternoonMin;
    num afternoonProm;

    num nightMax;
    num nightMin;
    num nightProm;

    num earlyMorningMax;
    num earlyMorningMin;
    num earlyMorningProm;

    FormatPDF(
        this.nombrePaciente,
        this.dateStart,
        this.dateEnd,
        this.globalMax,
        this.globalMin,
        this.globalProm,
        this.morningMax,
        this.morningMin,
        this.morningProm,
        this.afternoonMax,
        this.afternoonMin,
        this.afternoonProm,
        this.nightMax,
        this.nightMin,
        this.nightProm,
        this.earlyMorningMax,
        this.earlyMorningMin,
        this.earlyMorningProm,
    );
  }




