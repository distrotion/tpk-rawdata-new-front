import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/global.dart';
import '../../page/P31ReportPDFcommon/ReportPDFCommonMain.dart';
import '../../page/P31ReportPDFcommon/ReportPDFCommonvar.dart';
import '../../widget/common/Loading.dart';

String server = 'http://172.23.10.40:16700/';

class ReportPDFCommon_Cubit extends Cubit<CommonReportOutput> {
  ReportPDFCommon_Cubit()
      : super(CommonReportOutput(databasic: BasicCommonDATA()));

  Future<void> ReportPDFCommonCubit(String PO) async {
    CommonReportOutput output =
        CommonReportOutput(databasic: BasicCommonDATA());
    BasicCommonDATA BasicCommonDATAs = BasicCommonDATA();
    List<String> passlist = [];

    FreeLoading(ReportPDFCommoncontext);

    final response = await Dio().post(
      GLOserverRAW + "RAWDATA/getrawreport",
      data: {
        "Order": PO,
      },
    );

    if (response.statusCode == 200) {
      var databuff = response.data;
      output.datain = [];
      // print(databuff.length);
      if (databuff.length > 0) {
        output.databasic.PO = databuff[0]['Order'];
        output.databasic.CP = databuff[0]['CP'];
        output.databasic.CUSTOMER = databuff[0]['CUST_FULLNM'];
        output.databasic.TPKLOT = databuff[0]['FG_CHARG'];
        output.databasic.CUSLOT = databuff[0]['CUSLOTNO'];
        output.databasic.PARTNO = databuff[0]['PARTNA'];

        output.databasic.QTY = databuff[0]['QTYT'];
        output.databasic.UNITSAP = databuff[0]['UNIT'];

        // print(databuff.lenght);
        //3410000803
        for (var i = 0; i < databuff.length; i++) {
          output.datain.add(FINALCHECKlistCommonClass(
            date: databuff[i]['date'],
            Location: databuff[i]['Location'] != null
                ? databuff[i]['Location'].toString()
                : "",
            Plant: databuff[i]['Plant'] != null
                ? databuff[i]['Plant'].toString()
                : "",
            Order: databuff[i]['Order'] != null
                ? databuff[i]['Order'].toString()
                : "",
            CP: databuff[i]['CP'] != null ? databuff[i]['CP'].toString() : "",
            FG: databuff[i]['FG'] != null ? databuff[i]['FG'].toString() : "",
            ItemsCode: databuff[i]['ItemsCode'] != null
                ? databuff[i]['ItemsCode'].toString()
                : "",
            ItemsName: databuff[i]['ItemsName'] != null
                ? databuff[i]['ItemsName'].toString()
                : "",
            DataNo: databuff[i]['DataNo'] != null
                ? databuff[i]['DataNo'].toString()
                : "",
            Data: databuff[i]['Data'] != null
                ? databuff[i]['Data'].toString()
                : "",
            Picture: databuff[i]['Picture'] != null
                ? databuff[i]['Picture'].toString()
                : "",
            NUMBER: databuff[i]['NUMBER'] != null
                ? databuff[i]['NUMBER'].toString()
                : "",
            POINT: databuff[i]['POINT'] != null
                ? databuff[i]['POINT'].toString()
                : "",
            TYPE: databuff[i]['TYPE'] != null
                ? databuff[i]['TYPE'].toString()
                : "",
            SP01: databuff[i]['SP01'] != null
                ? databuff[i]['SP01'].toString()
                : "",
          ));
        }
      }
    }
    Navigator.pop(ReportPDFCommoncontext);
    // print(passlist);
    // print(BasicCommonDATAs.PASS);.reversed;
    // 123456789
    output.datain = output.datain.reversed.toList();
    emit(output);
  }

  Future<void> Flush() async {
    CommonReportOutput output = CommonReportOutput(
      databasic: BasicCommonDATA(),
    );
    emit(output);
  }
}

class FINALCHECKlistCommonClass {
  FINALCHECKlistCommonClass({
    this.date = '',
    this.Location = '',
    this.Plant = '',
    this.Order = '',
    this.CP = '',
    this.FG = '',
    this.ItemsCode = '',
    this.ItemsName = '',
    this.DataNo = '',
    this.Data = '',
    this.Picture = '',
    this.NUMBER = '',
    this.POINT = '',
    this.TYPE = '',
    this.SP01 = '',
  });
  String date;
  String Location;
  String Plant;
  String Order;
  String CP;
  String FG;
  String ItemsCode;
  String ItemsName;
  String DataNo;
  String Data;
  String Picture;
  String NUMBER;
  String POINT;
  String TYPE;
  String SP01;
}

// class datainlist {
//   datainlist({
//     this.dimensionX = 0,
//     this.dimensionY = 0,
//     this.DATA01 = '',
//     this.DATA02 = '',
//     this.DATA03 = '',
//     this.DATA04 = '',
//     this.DATA05 = '',
//     this.DATA06 = '',
//     this.DATA07 = '',
//     this.DATA08 = '',
//     this.DATA09 = '',
//     this.DATA10 = '',
//     this.DATA11 = '',
//     this.DATA12 = '',
//     this.DATA13 = '',
//     this.DATA14 = '',
//     this.DATA15 = '',
//     this.DATA16 = '',
//     this.DATA17 = '',
//     this.DATA18 = '',
//     this.DATA19 = '',
//     this.DATA20 = '',
//     this.DATAAVG = '',
//   });

//   int dimensionX;
//   int dimensionY;

//   String DATA01;
//   String DATA02;
//   String DATA03;
//   String DATA04;
//   String DATA05;
//   String DATA06;
//   String DATA07;
//   String DATA08;
//   String DATA09;
//   String DATA10;
//   String DATA11;
//   String DATA12;
//   String DATA13;
//   String DATA14;
//   String DATA15;
//   String DATA16;
//   String DATA17;
//   String DATA18;
//   String DATA19;
//   String DATA20;
//   String DATAAVG;
// }

// class datainlist {
//   datainlist({
//     this.TYPE = '',
//     this.dimensionX = 0,
//     this.dimensionY = 0,
//     this.DATA01 = '',
//     this.DATA02 = '',
//     this.DATA03 = '',
//     this.DATA04 = '',
//     this.DATA05 = '',
//     this.DATA06 = '',
//     this.DATA07 = '',
//     this.DATA08 = '',
//     this.DATA09 = '',
//     this.DATA10 = '',
//     this.DATA11 = '',
//     this.DATA12 = '',
//     this.DATA13 = '',
//     this.DATA14 = '',
//     this.DATA15 = '',
//     this.DATA16 = '',
//     this.DATA17 = '',
//     this.DATA18 = '',
//     this.DATA19 = '',
//     this.DATA20 = '',
//     this.DATA01p = '',
//     this.DATA02p = '',
//     this.DATA03p = '',
//     this.DATA04p = '',
//     this.DATA05p = '',
//     this.DATA06p = '',
//     this.DATA07p = '',
//     this.DATA08p = '',
//     this.DATA09p = '',
//     this.DATA10p = '',
//     this.DATA11p = '',
//     this.DATA12p = '',
//     this.DATA13p = '',
//     this.DATA14p = '',
//     this.DATA15p = '',
//     this.DATA16p = '',
//     this.DATA17p = '',
//     this.DATA18p = '',
//     this.DATA19p = '',
//     this.DATA20p = '',
//     this.DATAAVG = '',
//   });
//   String TYPE;
//   int dimensionX;
//   int dimensionY;

//   String DATA01;
//   String DATA02;
//   String DATA03;
//   String DATA04;
//   String DATA05;
//   String DATA06;
//   String DATA07;
//   String DATA08;
//   String DATA09;
//   String DATA10;
//   String DATA11;
//   String DATA12;
//   String DATA13;
//   String DATA14;
//   String DATA15;
//   String DATA16;
//   String DATA17;
//   String DATA18;
//   String DATA19;
//   String DATA20;
//   String DATA01p;
//   String DATA02p;
//   String DATA03p;
//   String DATA04p;
//   String DATA05p;
//   String DATA06p;
//   String DATA07p;
//   String DATA08p;
//   String DATA09p;
//   String DATA10p;
//   String DATA11p;
//   String DATA12p;
//   String DATA13p;
//   String DATA14p;
//   String DATA15p;
//   String DATA16p;
//   String DATA17p;
//   String DATA18p;
//   String DATA19p;
//   String DATA20p;
//   String DATAAVG;
// }

class BasicCommonDATA {
  BasicCommonDATA({
    this.PO = '',
    this.CP = '',
    this.CUSTOMER = '',
    this.PROCESS = '',
    this.PARTNAME = '',
    this.PARTNO = '',
    this.CUSLOT = '',
    this.TPKLOT = '',
    this.MATERIAL = '',
    this.QTY = '',
    this.UNITSAP = '',
    this.PICstd = '',
    this.PIC01 = '',
    this.PIC02 = '',
    this.PIC03 = '',
    this.PARTNAMEref = '',
    this.PARTref = '',
    this.PASS = '',
    this.INC01 = '',
    this.INC02 = '',
    this.USER_STATUS = '',
    this.reportset = '',
  });

  String PO;
  String CP;
  String CUSTOMER;
  String PROCESS;
  String PARTNAME;
  String PARTNO;
  String CUSLOT;
  String TPKLOT;
  String MATERIAL;
  String QTY;
  String PICstd;
  String UNITSAP;
  String PIC01;
  String PIC02;
  String PIC03;

  String PARTNAMEref;
  String PARTref;

  String PASS;

  String INC01;
  String INC02;

  String USER_STATUS;
  String reportset;
}

class CommonReportOutput {
  CommonReportOutput({
    this.datain = const [],
    required this.databasic,
  });

  List<FINALCHECKlistCommonClass> datain;
  BasicCommonDATA databasic;
}

bool checkdata(double maxdata, double mindata, double input) {
  if (maxdata != 0 && mindata != 0) {
    if (input < mindata || input > maxdata) {
      return false;
    } else {
      return true;
    }
  } else if (maxdata != 0 && mindata == 0) {
    if (input > maxdata) {
      return false;
    } else {
      return true;
    }
  } else if (maxdata == 0 && mindata != 0) {
    if (input < mindata) {
      return false;
    } else {
      return true;
    }
  } else {
    return true;
  }
}
