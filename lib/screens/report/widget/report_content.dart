import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _circleWelcomeTip(context),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: Text('Reporte GG',
          //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          // ),
          // MaterialButton(
          //   onPressed: () => showDialog<String>(
          //       context: context,
          //       builder: (BuildContext context) => _showAlertDialog(context)
          //   ),
          //   color: Colors.red,
          //   child: Text('CALEN', style: TextStyle(color: Colors.white)),
          // ),
          // FloatingActionButton(
          //   onPressed: (){},
          //   child: Icon(Icons.calendar_today_rounded,size: 35.0),
          //   elevation: 0.0,
          //   backgroundColor: Colors.amber,
          // ),
          // FloatingActionButton(
          //   onPressed: (){},
          //   child: Icon(Icons.keyboard_arrow_left,size: 35.0),
          //   elevation: 0.0,
          //   backgroundColor: Colors.amber,
          // ),
          // FloatingActionButton(
          //   onPressed: (){},
          //   child: Icon(Icons.keyboard_arrow_right,size: 35.0),
          //   elevation: 0.0,
          //   backgroundColor: Colors.amber,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: Text('Reporte GG1',
          //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: Text('Reporte GG2',
          //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          // ),
        ],
      ),
    );
  }

  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   print(args);
  //   print(DateFormat('dd/MM/yyyy').format(args.value.startDate).toString());
  //   print(DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)
  //       .toString());
  //   // TODO: implement your code here
  // }
  //
  // Widget containerCalendar(BuildContext context) {
  //   return Container(
  //     width: 120,
  //     height: 220,
  //     child: SfDateRangePicker(
  //       onSelectionChanged: _onSelectionChanged,
  //       view: DateRangePickerView.month,
  //       monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
  //       selectionMode: DateRangePickerSelectionMode.range,
  //     ),
  //   );
  // }

  Widget _circleWelcomeTip(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Container(
          width: double.infinity,
          height: 120,
          padding: new EdgeInsets.all(10.0),
          child: Card (
            margin: EdgeInsets.all(10),
            color: ColorConstants.primaryColor,
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                    title: Text(
                      "TextConstants.",
                      style: TextStyle(fontSize: 20,color: ColorConstants.white),
                    ),
                    subtitle: Text(
                        "TextConstants.",
                        style: TextStyle(color: ColorConstants.reportColor)),
                    trailing: Container(
                      child: Image(
                        image: NetworkImage('https://avatars.githubusercontent.com/u/109951?s=400&v=4'),
                        height: 40,
                      ),
                    )
                  //trailing: Icon(Icons.read_more),

                ),

              ],
            ),
          ),
        )
    );
  }

  // Widget _showAlertDialog(BuildContext context) {
  //
  //   return AlertDialog(
  //     title: const Text('AlertDialog Title'),
  //     content: containerCalendar(context),
  //     actions: <Widget>[
  //       TextButton(
  //         onPressed: () => Navigator.pop(context, 'Cancel'),
  //         child: const Text('Cancel'),
  //       ),
  //       TextButton(
  //         onPressed: () => Navigator.pop(context, 'OK'),
  //         child: const Text('OK'),
  //       ),
  //     ],
  //   );

  // }


}
