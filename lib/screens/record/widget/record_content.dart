import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/data/pressure_data.dart';
import 'package:your_pulse_health/screens/record/bloc/record_bloc.dart';
import 'package:your_pulse_health/screens/record/widget/pressure_card_bpm.dart';

class RecordContent extends StatelessWidget {
  final List<PressureData> pressureData;

  const RecordContent({
    required this.pressureData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.homeBackgroundColor,
      height: double.infinity,
      width: double.infinity,
      child: _createRecordBody(context),
    );
  }

  Widget _createRecordBody(BuildContext context) {
    //final bloc = BlocProvider.of<RecordBloc>(context);
    List<BpmData> _chartData = getChartData();
    TooltipBehavior _tooltipBehavior =  TooltipBehavior(enable: true);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _selectionPeriod(context),
                  SizedBox(height: 10,),
                  _graphValue(context,_chartData,_tooltipBehavior),
                  _listPressures(context)
                ],
              ),
            )
        ]
      ),
    );
  }

  Widget _selectionPeriod(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10,),
        MaterialButton(
          child: Text("Semana", style: TextStyle(color: ColorConstants.white),),
          color: ColorConstants.primaryColor,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          onPressed: (){ BlocProvider.of<RecordBloc>(context).add(GetPressureEvent(filterDate: DateFilter.semana));},
        // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
        SizedBox(width: 10,),
        MaterialButton(
          child: Text("Mes", style: TextStyle(color: ColorConstants.white),),
          color: ColorConstants.primaryColor,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          onPressed: (){ BlocProvider.of<RecordBloc>(context).add(GetPressureEvent(filterDate: DateFilter.mes));},
        // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
        ),
        SizedBox(width: 10,),
        MaterialButton(
          child: Text("Trimestre", style: TextStyle(color: ColorConstants.white),),
          color: ColorConstants.primaryColor,
          shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          onPressed: (){
            BlocProvider.of<RecordBloc>(context).add(GetPressureEvent(filterDate: DateFilter.trimestre));
          },
        // shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
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
      ],
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
          onPressed: (){
            Navigator.pop(context, 'OK');
            //
            //
            //BlocProvider.of<RecordBloc>(context).add(GetPressureEvent(filterDate: DateFilter.trimestre));
          },
          child: const Text('Seleccionar'),
        ),
      ],
    );

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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    print(args);
    //fecha seleccionada
    print(DateFormat('dd/MM/yyyy').format(args.value.startDate).toString());
    print(DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)
        .toString());
  }

  Widget _graphValue(BuildContext context, List<BpmData> chartData, TooltipBehavior tooltipBehavior, ) {
    // return SfCartesianChart(
    //   title: ChartTitle(text: 'Ritmo Cardiaco'),
    //   legend: Legend(isVisible: false),
    //   tooltipBehavior: tooltipBehavior,
    //   series: <ChartSeries>[
    //     LineSeries<SalesData, double>(
    //         name: 'BPM',
    //         dataSource: chartData,
    //         xValueMapper: (SalesData sales, _) => sales.year,
    //         yValueMapper: (SalesData sales, _) => sales.sales,
    //         dataLabelSettings: DataLabelSettings(isVisible: true),
    //         enableTooltip: true)
    //   ],
    //   primaryXAxis: NumericAxis(
    //     edgeLabelPlacement: EdgeLabelPlacement.shift,
    //   ),
    //   primaryYAxis: NumericAxis(
    //       labelFormat: '{value}M',
    //       numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
    // );
    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(),
      series: <ChartSeries<BpmData, DateTime>>[
        LineSeries(
          dataSource: chartData,
          xValueMapper: (BpmData sales, _) => sales.x,
          yValueMapper: (BpmData sales, _) => sales.y,
        )
      ],
    );
  }

  Widget _listPressures(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Text(
              "Medidas Tomadas",
              style: TextStyle(color: Colors.black, fontSize: 18,fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Container(
          height: 330,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: pressureData
    //children: DataConstants.bpms
                .map(
                  (e) => _createBPMCard(e,context),
            )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _createBPMCard(PressureData pressureData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5,left: 20,right: 20,top: 5),
      child: PressureHomeCard(
        color: ColorConstants.primaryColor,
        pressure: pressureData,
        onTap: () {  },

      )
    );
  }

  List<BpmData> getChartData() {
    final List<PressureData> listPressureData = pressureData;
    final List<BpmData> chartData = [];
    print(listPressureData.length);
    for ( int i=0;i<listPressureData.length;i++){
      print(listPressureData[i].date);
      print(listPressureData[i].bpm);
      chartData.add(BpmData(listPressureData[i].date!,listPressureData[i].bpm!));
    }

    return chartData;
  }
}

class BpmData {
  BpmData(this.x, this.y);
  final DateTime x;
  final int y;
}
