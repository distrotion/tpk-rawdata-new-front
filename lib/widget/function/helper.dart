import 'dart:convert';
import 'dart:html';
import 'dart:ui' as dart_ui;

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';

import 'dart:async';
import 'package:pdf/widgets.dart' as pw;

String server = 'http://172.23.10.40:16700/';
// String server = 'http://127.0.0.1:16700/';

class FileSaveHelper {
  static Future<void> saveAndLaunchFile(
      List<int> bytes, String fileName) async {
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', fileName)
      ..click();
  }
}

Future<String> capture1(
    GlobalKey<State<StatefulWidget>> globalKey, String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary!.toImage(pixelRatio: 1.5);

    final ByteData? bytes =
        await image.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    final imagePDF = pw.MemoryImage(
      dataImage,
    );

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF)]),
        ),
      ),
    );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

Future<String> capture2(GlobalKey<State<StatefulWidget>> globalKey1,
    GlobalKey<State<StatefulWidget>> globalKey2, String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary1 =
        globalKey1.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image1 = await boundary1!.toImage(pixelRatio: 1.5);

    final ByteData? bytes1 =
        await image1.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final imagePDF1 = pw.MemoryImage(
      dataImage1,
    );
    //-----------
    RenderRepaintBoundary? boundary2 =
        globalKey2.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image2 = await boundary2!.toImage(pixelRatio: 1.5);

    final ByteData? bytes2 =
        await image2.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final imagePDF2 = pw.MemoryImage(
      dataImage2,
    );
    //-----------

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF1)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF2)]),
        ),
      ),
    );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

Future<String> capture3(
    GlobalKey<State<StatefulWidget>> globalKey1,
    GlobalKey<State<StatefulWidget>> globalKey2,
    GlobalKey<State<StatefulWidget>> globalKey3,
    String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary1 =
        globalKey1.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image1 = await boundary1!.toImage(pixelRatio: 1.5);

    final ByteData? bytes1 =
        await image1.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final imagePDF1 = pw.MemoryImage(
      dataImage1,
    );
    //-----------
    RenderRepaintBoundary? boundary2 =
        globalKey2.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image2 = await boundary2!.toImage(pixelRatio: 1.5);

    final ByteData? bytes2 =
        await image2.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final imagePDF2 = pw.MemoryImage(
      dataImage2,
    );
    //-----------
    RenderRepaintBoundary? boundary3 =
        globalKey3.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image3 = await boundary3!.toImage(pixelRatio: 1.5);

    final ByteData? bytes3 =
        await image3.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage3 =
        bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);

    final imagePDF3 = pw.MemoryImage(
      dataImage3,
    );
    //-----------

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF1)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF2)]),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF3)]),
        ),
      ),
    );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

//genfloder

Future<String> captureToback(
    GlobalKey<State<StatefulWidget>> globalKey, String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image = await boundary!.toImage(pixelRatio: 2);

    final ByteData? bytes =
        await image.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage =
        bytes!.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);

    final imageEncoded = base64.encode(dataImage);

    // print(imageEncoded);
    final response = await Dio().post(
      server + 'goPDF',
      data: {
        "PIC": imageEncoded,
        "PO": PO,
      },
    );
    String output = '';

    if (response.statusCode == 200) {
      var databuff = response.data;

      // output = 'OK';
      if (databuff['PIC'] != null) {
        // final imageEncoded = base64.encode(databuff['PIC']);
        var base64 = databuff['PIC'].toString();
        var bytes = base64Decode(base64);
        await FileSaveHelper.saveAndLaunchFile(bytes, '${PO}.pdf');
      }
    } else {
      //
    }
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

// num? percentageToValue(String? value, num size) {
//   if (value != null) {
//     return value.contains('%')
//         ? (size / 100) * num.tryParse(value.replaceAll(RegExp('%'), ''))!
//         : num.tryParse(value);
//   }
//   return null;
// }

Future<String> capture7(
    GlobalKey<State<StatefulWidget>> globalKey1,
    GlobalKey<State<StatefulWidget>> globalKey2,
    GlobalKey<State<StatefulWidget>> globalKey3,
    GlobalKey<State<StatefulWidget>> globalKey4,
    GlobalKey<State<StatefulWidget>> globalKey5,
    GlobalKey<State<StatefulWidget>> globalKey6,
    GlobalKey<State<StatefulWidget>> globalKey7,
    String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary1 =
        globalKey1.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image1 = await boundary1!.toImage(pixelRatio: 1.5);

    final ByteData? bytes1 =
        await image1.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final imagePDF1 = pw.MemoryImage(
      dataImage1,
    );
    //-----------
    RenderRepaintBoundary? boundary2 =
        globalKey2.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image2 = await boundary2!.toImage(pixelRatio: 1.5);

    final ByteData? bytes2 =
        await image2.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final imagePDF2 = pw.MemoryImage(
      dataImage2,
    );
    //-----------
    RenderRepaintBoundary? boundary3 =
        globalKey3.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image3 = await boundary3!.toImage(pixelRatio: 1.5);

    final ByteData? bytes3 =
        await image3.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage3 =
        bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);

    final imagePDF3 = pw.MemoryImage(
      dataImage3,
    );
    //-----------
    RenderRepaintBoundary? boundary4 =
        globalKey4.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image4 = await boundary4!.toImage(pixelRatio: 1.5);

    final ByteData? bytes4 =
        await image4.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage4 =
        bytes4!.buffer.asUint8List(bytes4.offsetInBytes, bytes4.lengthInBytes);

    final imagePDF4 = pw.MemoryImage(
      dataImage4,
    );
    //-----------
    RenderRepaintBoundary? boundary5 =
        globalKey5.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image5 = await boundary5!.toImage(pixelRatio: 1.5);

    final ByteData? bytes5 =
        await image5.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage5 =
        bytes5!.buffer.asUint8List(bytes5.offsetInBytes, bytes5.lengthInBytes);

    final imagePDF5 = pw.MemoryImage(
      dataImage5,
    );
    //-----------
    RenderRepaintBoundary? boundary6 =
        globalKey6.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image6 = await boundary6!.toImage(pixelRatio: 1.5);

    final ByteData? bytes6 =
        await image6.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage6 =
        bytes6!.buffer.asUint8List(bytes6.offsetInBytes, bytes6.lengthInBytes);

    final imagePDF6 = pw.MemoryImage(
      dataImage6,
    );
    //-----------
    RenderRepaintBoundary? boundary7 =
        globalKey7.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image7 = await boundary7!.toImage(pixelRatio: 1.5);

    final ByteData? bytes7 =
        await image7.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage7 =
        bytes7!.buffer.asUint8List(bytes7.offsetInBytes, bytes7.lengthInBytes);

    final imagePDF7 = pw.MemoryImage(
      dataImage7,
    );
    //-----------

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF1)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF2)]),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF3)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF4)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF5)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF6)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF7)]),
        ),
      ),
    );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

Future<String> capture4(
    GlobalKey<State<StatefulWidget>> globalKey1,
    GlobalKey<State<StatefulWidget>> globalKey2,
    GlobalKey<State<StatefulWidget>> globalKey3,
    GlobalKey<State<StatefulWidget>> globalKey4,
    // GlobalKey<State<StatefulWidget>> globalKey5,
    // GlobalKey<State<StatefulWidget>> globalKey6,
    // GlobalKey<State<StatefulWidget>> globalKey7,
    String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary1 =
        globalKey1.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image1 = await boundary1!.toImage(pixelRatio: 1.5);

    final ByteData? bytes1 =
        await image1.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final imagePDF1 = pw.MemoryImage(
      dataImage1,
    );
    //-----------
    RenderRepaintBoundary? boundary2 =
        globalKey2.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image2 = await boundary2!.toImage(pixelRatio: 1.5);

    final ByteData? bytes2 =
        await image2.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final imagePDF2 = pw.MemoryImage(
      dataImage2,
    );
    //-----------
    RenderRepaintBoundary? boundary3 =
        globalKey3.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image3 = await boundary3!.toImage(pixelRatio: 1.5);

    final ByteData? bytes3 =
        await image3.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage3 =
        bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);

    final imagePDF3 = pw.MemoryImage(
      dataImage3,
    );
    //-----------
    RenderRepaintBoundary? boundary4 =
        globalKey4.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image4 = await boundary4!.toImage(pixelRatio: 1.5);

    final ByteData? bytes4 =
        await image4.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage4 =
        bytes4!.buffer.asUint8List(bytes4.offsetInBytes, bytes4.lengthInBytes);

    final imagePDF4 = pw.MemoryImage(
      dataImage4,
    );
    //-----------
    // RenderRepaintBoundary? boundary5 =
    //     globalKey5.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // final image5 = await boundary5!.toImage(pixelRatio: 1.5);

    // final ByteData? bytes5 =
    //     await image5.toByteData(format: dart_ui.ImageByteFormat.png);
    // Uint8List dataImage5 =
    //     bytes5!.buffer.asUint8List(bytes5.offsetInBytes, bytes5.lengthInBytes);

    // final imagePDF5 = pw.MemoryImage(
    //   dataImage5,
    // );
    //-----------
    // RenderRepaintBoundary? boundary6 =
    //     globalKey6.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // final image6 = await boundary6!.toImage(pixelRatio: 1.5);

    // final ByteData? bytes6 =
    //     await image6.toByteData(format: dart_ui.ImageByteFormat.png);
    // Uint8List dataImage6 =
    //     bytes6!.buffer.asUint8List(bytes6.offsetInBytes, bytes6.lengthInBytes);

    // final imagePDF6 = pw.MemoryImage(
    //   dataImage6,
    // );
    // //-----------
    // RenderRepaintBoundary? boundary7 =
    //     globalKey7.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // final image7 = await boundary7!.toImage(pixelRatio: 1.5);

    // final ByteData? bytes7 =
    //     await image7.toByteData(format: dart_ui.ImageByteFormat.png);
    // Uint8List dataImage7 =
    //     bytes7!.buffer.asUint8List(bytes7.offsetInBytes, bytes7.lengthInBytes);

    // final imagePDF7 = pw.MemoryImage(
    //   dataImage7,
    // );
    // //-----------

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF1)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF2)]),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF3)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF4)]),
        ),
      ),
    );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(4),
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(children: [pw.Image(imagePDF5)]),
    //     ),
    //   ),
    // );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(4),
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(children: [pw.Image(imagePDF6)]),
    //     ),
    //   ),
    // );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(4),
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(children: [pw.Image(imagePDF7)]),
    //     ),
    //   ),
    // );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

Future<String> capture5(
    GlobalKey<State<StatefulWidget>> globalKey1,
    GlobalKey<State<StatefulWidget>> globalKey2,
    GlobalKey<State<StatefulWidget>> globalKey3,
    GlobalKey<State<StatefulWidget>> globalKey4,
    GlobalKey<State<StatefulWidget>> globalKey5,
    // GlobalKey<State<StatefulWidget>> globalKey6,
    // GlobalKey<State<StatefulWidget>> globalKey7,
    String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary1 =
        globalKey1.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image1 = await boundary1!.toImage(pixelRatio: 1.5);

    final ByteData? bytes1 =
        await image1.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final imagePDF1 = pw.MemoryImage(
      dataImage1,
    );
    //-----------
    RenderRepaintBoundary? boundary2 =
        globalKey2.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image2 = await boundary2!.toImage(pixelRatio: 1.5);

    final ByteData? bytes2 =
        await image2.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final imagePDF2 = pw.MemoryImage(
      dataImage2,
    );
    //-----------
    RenderRepaintBoundary? boundary3 =
        globalKey3.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image3 = await boundary3!.toImage(pixelRatio: 1.5);

    final ByteData? bytes3 =
        await image3.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage3 =
        bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);

    final imagePDF3 = pw.MemoryImage(
      dataImage3,
    );
    //-----------
    RenderRepaintBoundary? boundary4 =
        globalKey4.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image4 = await boundary4!.toImage(pixelRatio: 1.5);

    final ByteData? bytes4 =
        await image4.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage4 =
        bytes4!.buffer.asUint8List(bytes4.offsetInBytes, bytes4.lengthInBytes);

    final imagePDF4 = pw.MemoryImage(
      dataImage4,
    );
    //-----------
    RenderRepaintBoundary? boundary5 =
        globalKey5.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image5 = await boundary5!.toImage(pixelRatio: 1.5);

    final ByteData? bytes5 =
        await image5.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage5 =
        bytes5!.buffer.asUint8List(bytes5.offsetInBytes, bytes5.lengthInBytes);

    final imagePDF5 = pw.MemoryImage(
      dataImage5,
    );
    //-----------
    // RenderRepaintBoundary? boundary6 =
    //     globalKey6.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // final image6 = await boundary6!.toImage(pixelRatio: 1.5);

    // final ByteData? bytes6 =
    //     await image6.toByteData(format: dart_ui.ImageByteFormat.png);
    // Uint8List dataImage6 =
    //     bytes6!.buffer.asUint8List(bytes6.offsetInBytes, bytes6.lengthInBytes);

    // final imagePDF6 = pw.MemoryImage(
    //   dataImage6,
    // );
    // //-----------
    // RenderRepaintBoundary? boundary7 =
    //     globalKey7.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // final image7 = await boundary7!.toImage(pixelRatio: 1.5);

    // final ByteData? bytes7 =
    //     await image7.toByteData(format: dart_ui.ImageByteFormat.png);
    // Uint8List dataImage7 =
    //     bytes7!.buffer.asUint8List(bytes7.offsetInBytes, bytes7.lengthInBytes);

    // final imagePDF7 = pw.MemoryImage(
    //   dataImage7,
    // );
    // //-----------

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF1)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF2)]),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF3)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF4)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF5)]),
        ),
      ),
    );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(4),
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(children: [pw.Image(imagePDF6)]),
    //     ),
    //   ),
    // );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(4),
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(children: [pw.Image(imagePDF7)]),
    //     ),
    //   ),
    // );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}

Future<String> capture6(
    GlobalKey<State<StatefulWidget>> globalKey1,
    GlobalKey<State<StatefulWidget>> globalKey2,
    GlobalKey<State<StatefulWidget>> globalKey3,
    GlobalKey<State<StatefulWidget>> globalKey4,
    GlobalKey<State<StatefulWidget>> globalKey5,
    GlobalKey<State<StatefulWidget>> globalKey6,
    // GlobalKey<State<StatefulWidget>> globalKey7,
    String PO) async {
  try {
    // FreeLoading(contextin);
    RenderRepaintBoundary? boundary1 =
        globalKey1.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image1 = await boundary1!.toImage(pixelRatio: 1.5);

    final ByteData? bytes1 =
        await image1.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage1 =
        bytes1!.buffer.asUint8List(bytes1.offsetInBytes, bytes1.lengthInBytes);

    final imagePDF1 = pw.MemoryImage(
      dataImage1,
    );
    //-----------
    RenderRepaintBoundary? boundary2 =
        globalKey2.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image2 = await boundary2!.toImage(pixelRatio: 1.5);

    final ByteData? bytes2 =
        await image2.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage2 =
        bytes2!.buffer.asUint8List(bytes2.offsetInBytes, bytes2.lengthInBytes);

    final imagePDF2 = pw.MemoryImage(
      dataImage2,
    );
    //-----------
    RenderRepaintBoundary? boundary3 =
        globalKey3.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image3 = await boundary3!.toImage(pixelRatio: 1.5);

    final ByteData? bytes3 =
        await image3.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage3 =
        bytes3!.buffer.asUint8List(bytes3.offsetInBytes, bytes3.lengthInBytes);

    final imagePDF3 = pw.MemoryImage(
      dataImage3,
    );
    //-----------
    RenderRepaintBoundary? boundary4 =
        globalKey4.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image4 = await boundary4!.toImage(pixelRatio: 1.5);

    final ByteData? bytes4 =
        await image4.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage4 =
        bytes4!.buffer.asUint8List(bytes4.offsetInBytes, bytes4.lengthInBytes);

    final imagePDF4 = pw.MemoryImage(
      dataImage4,
    );
    //-----------
    RenderRepaintBoundary? boundary5 =
        globalKey5.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image5 = await boundary5!.toImage(pixelRatio: 1.5);

    final ByteData? bytes5 =
        await image5.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage5 =
        bytes5!.buffer.asUint8List(bytes5.offsetInBytes, bytes5.lengthInBytes);

    final imagePDF5 = pw.MemoryImage(
      dataImage5,
    );
    //-----------
    RenderRepaintBoundary? boundary6 =
        globalKey6.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    final image6 = await boundary6!.toImage(pixelRatio: 1.5);

    final ByteData? bytes6 =
        await image6.toByteData(format: dart_ui.ImageByteFormat.png);
    Uint8List dataImage6 =
        bytes6!.buffer.asUint8List(bytes6.offsetInBytes, bytes6.lengthInBytes);

    final imagePDF6 = pw.MemoryImage(
      dataImage6,
    );
    //-----------
    // RenderRepaintBoundary? boundary7 =
    //     globalKey7.currentContext?.findRenderObject() as RenderRepaintBoundary?;

    // final image7 = await boundary7!.toImage(pixelRatio: 1.5);

    // final ByteData? bytes7 =
    //     await image7.toByteData(format: dart_ui.ImageByteFormat.png);
    // Uint8List dataImage7 =
    //     bytes7!.buffer.asUint8List(bytes7.offsetInBytes, bytes7.lengthInBytes);

    // final imagePDF7 = pw.MemoryImage(
    //   dataImage7,
    // );
    // //-----------

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF1)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF2)]),
        ),
      ),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF3)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF4)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF5)]),
        ),
      ),
    );
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(4),
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [pw.Image(imagePDF6)]),
        ),
      ),
    );
    // pdf.addPage(
    //   pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     margin: pw.EdgeInsets.all(4),
    //     build: (pw.Context context) => pw.Center(
    //       child: pw.Column(children: [pw.Image(imagePDF7)]),
    //     ),
    //   ),
    // );

    final response = await Dio().post(
      server + 'genfloder',
      data: {
        "PIC": "imageEncoded",
        "PO": PO,
      },
    );

    // print(await pdf.save());
    final bytesPDF = await pdf.save();
    await FileSaveHelper.saveAndLaunchFile(bytesPDF, '${PO}.pdf');

    // Navigator.pop(contextin);
    return 'ok';
  } catch (e) {
    rethrow;
  }
}
