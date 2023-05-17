import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:your_pulse_health/core/const/color_constants.dart';
import 'package:your_pulse_health/core/const/data_constants.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/const/text_constants.dart';
import 'package:your_pulse_health/data/typepressure_data.dart';
import 'package:your_pulse_health/screens/bluetooth_config/page/bluetooth_page.dart';
import 'package:your_pulse_health/screens/bluetooth_config/page/discovery_page.dart';
import 'package:your_pulse_health/screens/pressure/bloc/pressure_bloc.dart';
import 'package:your_pulse_health/screens/pressure/widget/pressure_button.dart';
import 'package:oscilloscope/oscilloscope.dart';
import 'package:your_pulse_health/screens/pressure_camera/page/pressurecamera_page.dart';
import 'dart:math';

import 'package:your_pulse_health/screens/tab_bar/bloc/tab_bar_bloc.dart';

class PressureContent extends StatelessWidget {
  final List<TypePressureData> typepressures;


  const PressureContent({
    required this.typepressures,
    Key? key,
  }) : super(key: key);

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
    final bloc = BlocProvider.of<PressureBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text('Presión',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primaryColor
                    )
                ),
              ),
              const SizedBox(height: 90),
              _valueBPM(context, bloc),
              const SizedBox(height: 25),
              _graphValueBPM(context, bloc),
              const SizedBox(height: 25),
              _buttonSelectType(context,bloc),
              const SizedBox(height: 30),
            ],
          ),
        );
  }

  Widget _buttonSelectType (BuildContext context, PressureBloc bloc){
    return Expanded(
      child: Center(
        child: SizedBox.fromSize(
          size: Size(150, 150), // button width and height
          child: ClipOval(
            child: Material(
              color: ColorConstants.primaryColor, // button color
              child: InkWell(
                splashColor: ColorConstants.reportColor, // splash color
                onTap: () async {
                  chooseOptionPressure(context);
                },
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
                        TextConstants.pushPressure,
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
    );
  }

  chooseOptionPressure(BuildContext context) {
    final blocTabBar = BlocProvider.of<TabBarBloc>(context);
    List<TypePressureData> typePressure = DataConstants.typepressure;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.all(
              Radius.circular(10.0))),
      content: Builder(
        builder: (context) {
          return Container(
            height: 230,
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                PressureButton(
                    title: typePressure[0].text ?? "",
                    name: Icons.camera_alt,
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => PressureCameraPage()));
                    },
                ),
                const SizedBox(height: 12),
                PressureButton(
                    title: typePressure[1].text ?? "",
                    name: Icons.monitor_heart,
                    onTap: () async {
                    final BluetoothDevice? selectedDevice =
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return DiscoveryPage();
                        },
                      ),
                    );
                    if (selectedDevice != null) {
                      print('Discovery -> selected ' + selectedDevice.address);
                      _startChat(context, selectedDevice);
                    } else {
                      print('Discovery -> no device selected');
                    }
                  },
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

  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BluetoothPage(server: server);
          //return GraphData(server: server);
        },
      ),
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


  Widget _valueBPM(BuildContext context, PressureBloc bloc){
      final valuebpm = TextConstants.namePressure;
      final valuestatebpm = '60';
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
                const SizedBox(width: 100),
                Text('$day $month $year',
                    style: TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      );
  }

  Widget _graphValueBPM(BuildContext context, PressureBloc bloc){
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

}


