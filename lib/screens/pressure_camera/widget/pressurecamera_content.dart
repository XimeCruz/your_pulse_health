import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/core/util/heart_bpm/chart.dart';
import 'package:your_pulse_health/core/util/heart_bpm/heart_bpm.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/screens/pressure/bloc/pressure_bloc.dart';
import 'package:your_pulse_health/screens/pressure/widget/pressure_button.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'dart:math';
import 'package:your_pulse_health/screens/pressure_camera/bloc/pressurecamera_bloc.dart';

//class PressureCameraContent extends StatelessWidget {
class PressureCameraContent extends StatefulWidget {
  final List<TypePressureData> typepressures;

  const PressureCameraContent({
    required this.typepressures,
    Key? key,
  });

  @override
  State<PressureCameraContent> createState() => _PressureCameraContentState();

}

class _PressureCameraContentState extends State<PressureCameraContent> {
  List<SensorValue> data = [];
  List<SensorValue> bpmValues = [];
  int valuestatebpm = 60;
  //Widget chart = BPMChart(data);

  bool isBPMEnabled = false;
  Widget? dialog;

  /// variable to store measured BPM value
  //int bpmValue;

  @override
  Widget build(BuildContext context) {
      return Container(
        color: ColorConstants.homeBackgroundColor,
        height: double.infinity,
        width: double.infinity,
        child: _createPressureBody(context),
      );
  }

  Widget _createPressureBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _valueBPM(context,valuestatebpm),
            const SizedBox(height: 25),
            isBPMEnabled
                ? HeartBPMDialog(
              context: context,
              //context: context,
              onRawData: (value) {
                setState(() {
                  if (data.length == 100) data.removeAt(0);
                  data.add(value);
                });
              },
              onBPM: (value) => setState(() {
                valuestatebpm = value.toInt();
                print(value.toDouble());
                if (bpmValues.length >= 100) bpmValues.removeAt(0);
                bpmValues.add(SensorValue(
                    value: value.toDouble(), time: DateTime.now()));
              }),
            )
                : _graphValueBPM(context),
            // isBPMEnabled && data.isNotEmpty
            //     ? Container(
            //   decoration: BoxDecoration(border: Border.all()),
            //   height: 180,
            //   child: BPMChart(data),
            // )
            //     : SizedBox(),
            isBPMEnabled && bpmValues.isNotEmpty
                ? Container(
              decoration: BoxDecoration(border: Border.all()),
              constraints: BoxConstraints.expand(height: 180),
              child: BPMChart(bpmValues),
            )
                : SizedBox(),
            //boton
            Expanded(
                child: Center(
                    child: SizedBox.fromSize(
                      size: Size(150, 150), // button width and height
                      child: ClipOval(
                        child: Material(
                          color: ColorConstants.primaryColor, // button color
                          child: InkWell(
                            splashColor: ColorConstants.reportColor,
                            onTap: () => setState(() => isBPMEnabled = !isBPMEnabled),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                    PathConstants.iconButtonPressure,
                                  ),
                                  width: 30.0,
                                  height: 30.0,
                                ),
                                Text(
                                  isBPMEnabled ? TextConstants.stopPressure : TextConstants.pushPressure,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ), // text
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                ),
            ),
            ],
          ),
        );
  }

  Widget _graphValueBPM(BuildContext context){
    //Osciloscopio
    List<double> traceSine = [];
    List<double> traceCosine = [];
    double radians = 0.0;

    var sv = sin((radians * pi));
    //   var cv = cos((radians * pi));

    traceSine.add(sv);
    //traceCosine.add(cv);

    radians += 0.05;
    if (radians >= 2.0) {
      radians = 0.0;
    }

    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.black,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 1.0,
      backgroundColor: Colors.white,
      traceColor: Colors.green,
      yAxisMax: 1.0,
      yAxisMin: -1.0,
      dataSet: traceSine,
    );

    // Generate the Scaffold
    return Expanded(flex: 1, child: scopeOne);
  }
}

  // _generateTrace(Timer t) {
  //   // generate our  values
  //   var sv = sin((radians * pi));
  //   var cv = cos((radians * pi));
  //
  //   // Add to the growing dataset
  //   setState(() {
  //     traceSine.add(sv);
  //     traceCosine.add(cv);
  //   });
  //
  //   // adjust to recyle the radian value ( as 0 = 2Pi RADS)
  //   radians += 0.05;
  //   if (radians >= 2.0) {
  //     radians = 0.0;
  //   }
  // }



  //BLOC
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: ColorConstants.homeBackgroundColor,
  //     height: double.infinity,
  //     width: double.infinity,
  //     child: _createPressureBody(context),
  //   );
  // }
  //
  // Widget _createPressureBody(BuildContext context) {
  //   final bloc = BlocProvider.of<PressureCameraBloc>(context);
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 50),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //             const SizedBox(height: 20),
  //             _valueBPM(context, bloc),
  //             const SizedBox(height: 25),
  //             _graphValueBPM(context,bloc),
  //             const SizedBox(height: 25),
  //             _buttonSelectType(context,bloc),
  //             const SizedBox(height: 30),
  //           ],
  //         ),
  //       );
  // }



  chooseOptionPressure(BuildContext context) {
    List<TypePressureData> typePressure = DataConstants.typepressure;
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(
              Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          // Get available height and width of the build area of this widget. Make a choice depending on the size.
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;

          return Container(
            height: 200,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                PressureButton(
                    title: typePressure[0].text ?? "",
                    name: Icons.camera_alt,
                    onTap: () {

                    },
                ),
                const SizedBox(height: 12),
                PressureButton(
                    title: typePressure[1].text ?? "",
                    name: Icons.watch,
                    onTap: (){
                      chooseDeviceAvailable(context);
                    }
                ),
              ],
            ),
          );
        },
      ),
      title: Text(TextConstants.chosseSelection),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  chooseDeviceAvailable(BuildContext context) {
    List<TypePressureData> typePressure = DataConstants.typepressure;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(
              Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          return Container(
            height: 200,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                PressureButton(
                  title: typePressure[0].text ?? "",
                  name: Icons.camera_alt,
                  onTap: () {

                  },
                ),
                const SizedBox(height: 12),
                PressureButton(
                    title: typePressure[1].text ?? "",
                    name: Icons.watch,
                    onTap: (){

                    }
                ),
              ],
            ),
          );
        },
      ),
      title: Text(TextConstants.chosseDevice),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  Widget _valueBPM(BuildContext context, int valuestatebpm){
      final valuebpm = TextConstants.namePressure;

      final date = DateTime.now();
      final day = date.day;
      final months = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
      final month = months[date.month-1];
      final year = date.year;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('$valuestatebpm',
                          style: TextStyle(fontSize: 50)),
                      const SizedBox(width: 10),
                      Text('$valuebpm',
                          style: TextStyle(fontSize: 18, )),
                    ],
                  ),
                ),
                const SizedBox(width: 80),
                Text('$day $month $year',
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      );
  }

  Widget _graphValueBPM(BuildContext context, PressureCameraBloc bloc){
    //Osciloscopio
    List<double> traceSine = [];
    List<double> traceCosine = [];
    double radians = 0.0;

    var sv = sin((radians * pi));
    //   var cv = cos((radians * pi));

    traceSine.add(sv);
    //traceCosine.add(cv);

    radians += 0.05;
    if (radians >= 2.0) {
      radians = 0.0;
    }

    Oscilloscope scopeOne = Oscilloscope(
      showYAxis: true,
      yAxisColor: Colors.black,
      margin: EdgeInsets.all(20.0),
      strokeWidth: 1.0,
      backgroundColor: ColorConstants.homeBackgroundColor,
      traceColor: Colors.green,
      yAxisMax: 1.0,
      yAxisMin: -1.0,
      dataSet: traceSine,
    );

    // Generate the Scaffold
    return Expanded(flex: 1, child: scopeOne);
  }
  //
  // //osciloscopio
  // _generateTrace(Timer t) {
  //   // generate our  values
  //   var sv = sin((radians * pi));
  //   var cv = cos((radians * pi));
  //
  //   // Add to the growing dataset
  //   setState(() {
  //     traceSine.add(sv);
  //     traceCosine.add(cv);
  //   });
  //
  //   // adjust to recyle the radian value ( as 0 = 2Pi RADS)
  //   radians += 0.05;
  //   if (radians >= 2.0) {
  //     radians = 0.0;
  //   }
  // }




