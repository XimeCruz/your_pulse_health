import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
//import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:your_pulse_health/core/const/path_constants.dart';
import 'package:your_pulse_health/core/service/utils.dart';
import 'package:your_pulse_health/screens/report/widget/report_content.dart';


class PdfReportService {
  Future<Uint8List> createPdf(FormatPDF? formatPDF) async{
    final pdf = pw.Document();
    FormatPDF newFormatPDF = formatPDF!;

    final image = (await rootBundle.load(PathConstants.iconApplication))
        .buffer
        .asUint8List();
    pdf.addPage(
        pw.MultiPage(
          build: (context) => [

            buildHeader(image,formatPDF),
            pw.SizedBox(height: 3 * PdfPageFormat.cm),
            buildTitle(),
            buildInvoice(newFormatPDF),
            pw.Divider(),
            //buildTotal(),
          ],
          footer: (context) => buildFooter(),
        )
    );
    return pdf.save();
  }

  static pw.Widget buildHeader(Uint8List image, FormatPDF? formatPDF) => pw.Column(

    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          buildSupplierAddress(),
          pw.Container(
            height: 50,
            width: 50,
            child: pw.Image(pw.MemoryImage(image),
                width: 90, height: 130, fit: pw.BoxFit.cover),
            // child: pw.BarcodeWidget(
            //   barcode: pw.Barcode.qrCode(),
            //   data: "invoice.info.number",
            // ),
          ),
        ],
      ),
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          buildCustomerAddress(),
          buildInvoiceInfo(formatPDF),
        ],
      ),
    ],
  );

  static pw.Widget buildSupplierAddress() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("Your Pulse", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      pw.Text("Controla tu corazón,conoce tu salud"),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      pw.Text("Tu aliado para monitorizar tu presión cardiaca.")
    ],
  );

  static pw.Widget buildCustomerAddress() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text("Contactenos", style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
      pw.Text("yourpulse@gmail.com"),
    ],
  );

  static pw.Widget buildInvoiceInfo(FormatPDF? formatPDF) {
    final paymentTerms = '${DateTime.now().add(const Duration(days: 7),).difference(DateTime.now()).inDays} days';
    final titles = <String>[
      'Paciente:',
      //'Edad:',
      'Fecha de extraccion:',
      'Rango de fechas:'
    ];
    final data = <String>[
      '${formatPDF?.nombrePaciente}',
      Utils.formatDate(DateTime.now()),
      //paymentTerms,
      //Utils.formatDate(DateTime.now().add(const Duration(days: 7),)),
      '${formatPDF?.dateStart} - ${formatPDF?.dateEnd}',
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static pw.Widget buildTitle() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Reporte BPM',
        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
      //pw.Text("Reporte de medidas tomadas desde la fecha $dateStart a la fecha $dateEnd del paciente ${GlobalConstants.currentUser.name}"),
      pw.Text('Medidas tomadas en el periodo de tiempo'),
      pw.SizedBox(height: 0.8 * PdfPageFormat.cm),
    ],
  );

  static pw.Widget buildInvoice(FormatPDF formatPDF) {
    final List<InfoDataBPM>  listInfo= [
      InfoDataBPM("Global",formatPDF.globalMax,formatPDF.globalMin,formatPDF.globalProm),
      InfoDataBPM("Mañana",formatPDF.morningMax,formatPDF.morningMin,formatPDF.morningProm),
      InfoDataBPM("Tarde",formatPDF.afternoonMax,formatPDF.afternoonMin,formatPDF.afternoonProm),
      InfoDataBPM("Noche",formatPDF.nightMax,formatPDF.nightMin,formatPDF.nightProm),
      InfoDataBPM("Madrugada",formatPDF.earlyMorningMax,formatPDF.earlyMorningMin,formatPDF.earlyMorningProm),
    ];

    final headers = [
      'Tipo',
      'Maximo',
      'Minimo',
      'Promedio'
    ];
    final data = listInfo.map((item) {
      return [
        item.description,
        item.max,
        item.min,
        item.prom,
      ];
    }).toList();

    return pw.Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerRight,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.centerRight,
        4: pw.Alignment.centerRight,
        5: pw.Alignment.centerRight,
      },
    );
  }

  static pw.Widget buildTotal() {
    final netTotal = 100.0;
    final vatPercent = 50.0;
    final vat = 200.0;
    final total = 300.0;

    return pw.Container(
      alignment: pw.Alignment.centerRight,
      child: pw.Row(
        children: [
          pw.Spacer(flex: 6),
          pw.Expanded(
            flex: 4,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Net total',
                  value: Utils.formatPrice(netTotal),
                  unite: true,
                ),
                buildText(
                  title: 'Vat ${vatPercent * 100} %',
                  value: Utils.formatPrice(vat),
                  unite: true,
                ),
                pw.Divider(),
                buildText(
                  title: 'Total amount due',
                  titleStyle: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  value: Utils.formatPrice(total),
                  unite: true,
                ),
                pw.SizedBox(height: 2 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
                pw.SizedBox(height: 0.5 * PdfPageFormat.mm),
                pw.Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }







  static pw.Widget buildFooter() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.center,
    children: [
      pw.Divider(),
      pw.SizedBox(height: 2 * PdfPageFormat.mm),
      buildSimpleText(
          title: 'Your Pulse',
          value: ''
      ),
      pw.SizedBox(height: 1 * PdfPageFormat.mm),
      buildSimpleText(title: 'Copyright ©', value: "2023"),
    ],
  );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(value),
      ],
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    if(await _checkPermission()){
      final output = await getTemporaryDirectory();
      //var filePath = "${output.path}/$fileName.pdf";
      var filePath = "${await _getSavedDir()}/$fileName.pdf";
      final file = File(filePath);
      await file.writeAsBytes(byteList);
      //await OpenDocument.openDocument(filePath: filePath);
      await OpenFile.open(filePath, type: 'application/pdf');
    }
    else {
      print("ocurrio un error");
    }
  }
}

Future<String?> _getSavedDir() async {
  String? externalStorageDirPath;

  if (Platform.isAndroid) {
    try {
      externalStorageDirPath = (await getDownloadsDirectory())?.path;
    } catch (err,_) {
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
  } else if (Platform.isIOS) {
    externalStorageDirPath =
        (await getApplicationDocumentsDirectory()).absolute.path;
  }
  return externalStorageDirPath;
}

Future<bool> _checkPermission() async {
  //android 13
  if(Platform.isAndroid){
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    AndroidDeviceInfo android = await plugin.androidInfo;
    if(android.version.sdkInt >=33){
      return true;
    }
  }
  await Permission.storage.request();
  var per=await Permission.storage.request().isGranted;
  if(per){
    return per;
  }
  else{
    await Permission.storage.request();
  }
  return await Permission.storage.request().isGranted;
}


class InfoDataBPM {
  final String description;
  final num max;
  final num min;
  final num prom;

  InfoDataBPM(
      this.description,
      this.max,
      this.min,
      this.prom
      );
}