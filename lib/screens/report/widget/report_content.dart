import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/screens/report/bloc/report_bloc.dart';

class ReportContent extends StatelessWidget {
  final List<TypePressureData> typepressures;

  const ReportContent({
    required this.typepressures,
    Key? key,
  }) : super(key: key);

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
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _downloadDocument(context),
          _rectangleDate(context),
          Container(
            height: 550,
            child: ListView(
              scrollDirection: Axis.vertical,
                children: <Widget>[
                  _globalPressure(context),
                  _morningPressure(context),
                  _afternoonPressure(context),
                  _nightPressure(context),
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
          SizedBox(width: 10,),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: ColorConstants.primaryColor,
              borderRadius: BorderRadius.circular(15)
            ),
            //color: Colors.lightBlue,
            child: Text(
                'May 11 - May 18',
                style: TextStyle(
                    fontSize: 20,
                    color: ColorConstants.white
                )
            ),
          ),
         SizedBox(width: 10,),
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
          TextButton(
            child: const Icon(
                Icons.arrow_back_ios,
                size: 35,
                color: ColorConstants.primaryColor
            ),
            onPressed: () {},
          ),
          TextButton(
            child: const Icon(
                Icons.arrow_forward_ios,
                size: 35,
                color: ColorConstants.primaryColor
            ),
            onPressed: () {},
          ),
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
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('Pulso')),
                      DataCell(Text('90')),
                      DataCell(Text('80')),
                      DataCell(Text('85')),
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
                Text("Mañana(06-12)"),
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
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Pulso')),
                        DataCell(Text('90')),
                        DataCell(Text('80')),
                        DataCell(Text('85')),
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
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Pulso')),
                        DataCell(Text('90')),
                        DataCell(Text('80')),
                        DataCell(Text('85')),
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
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Pulso')),
                        DataCell(Text('90')),
                        DataCell(Text('80')),
                        DataCell(Text('85')),
                      ],
                    ),
                  ],
                )
              ],
            )
        )
    );
  }


}
