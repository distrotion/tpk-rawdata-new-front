import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P2INPUTRAWDATA2/P2INPUTRAWDATA2MAIN.dart';
import '../../page/P2INPUTRAWDATA2/P2INPUTRAWDATA2VAR.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/Safty.dart';
import '01-03-GETITEMS.dart';

//-------------------------------------------------

abstract class P2INPUTRAWDATA2_Event {}

class P2INPUTRAWDATA2_GET extends P2INPUTRAWDATA2_Event {}

class P2INPUTRAWDATA2_SET extends P2INPUTRAWDATA2_Event {}

class P2INPUTRAWDATA2_Bloc
    extends Bloc<P2INPUTRAWDATA2_Event, P2INPUTRAWDATA2class> {
  P2INPUTRAWDATA2_Bloc() : super(P2INPUTRAWDATA2class()) {
    on<P2INPUTRAWDATA2_GET>((event, emit) {
      return _P2INPUTRAWDATA2_GET(P2INPUTRAWDATA2class(), emit);
    });
    on<P2INPUTRAWDATA2_SET>((event, emit) {
      return _P2INPUTRAWDATA2_SET(P2INPUTRAWDATA2class(), emit);
    });
  }
  Future<void> _P2INPUTRAWDATA2_GET(
      P2INPUTRAWDATA2class toAdd, Emitter<P2INPUTRAWDATA2class> emit) async {
    P2INPUTRAWDATA2class output = P2INPUTRAWDATA2class();
    FreeLoading(P2INPUTRAWDATA2MAINcontext);
    final response = await Dio().post(
      // GLOserverRAW + 'RAWDATA/sapget',
      "http://172.23.10.40:1885/${P2INPUTRAWDATA2MAINVAR.LINKPLANT}",
      data: {
        "ORDER": P2INPUTRAWDATA2MAINVAR.ORDER,
      },
    );

    if (response.statusCode == 200) {
      var databuff = response.data;
      print(databuff);
      if (databuff.length > 0) {
        //
        output.PO = P2INPUTRAWDATA2MAINVAR.ORDER;
        output.SEQ = databuff[0]['SEQ'].toString();
        output.CPMAT = databuff[0]['CPMAT'].toString();
        output.FGMAT = databuff[0]['FGMAT'].toString();
        output.QTYT = databuff[0]['QTYT'].toString();
        output.UNIT = databuff[0]['UNIT'].toString();
        output.CUSTNA = databuff[0]['CUSTNA'].toString();
        output.PARTNA = databuff[0]['PARTNA'].toString();
        output.PARTNO = databuff[0]['PARTNO'].toString();
        output.PROC = databuff[0]['PROC'].toString();
        output.CUSLOTNO = databuff[0]['CUSLOTNO'].toString();
        output.FG_CHARG = databuff[0]['FG_CHARG'].toString();
        output.CUST_FULLNM = databuff[0]['CUST_FULLNM'].toString();
        P2INPUTRAWDATA2MAINVAR.CPGET =
            int.parse(ConverstStr(output.CPMAT)).toString();
      }
    } else {
      //
    }

    // print(P2INPUTRAWDATA2MAINVAR.CPGET);
    Navigator.pop(P2INPUTRAWDATA2MAINcontext);
    if (output.CPMAT.length > 6) {}

    P2INPUTRAWDATA2MAINcontext.read<GETITEMS_Bloc>().add(GETITEMS_GET());
    emit(output);
  }

  Future<void> _P2INPUTRAWDATA2_SET(
      P2INPUTRAWDATA2class toAdd, Emitter<P2INPUTRAWDATA2class> emit) async {
    P2INPUTRAWDATA2class output = P2INPUTRAWDATA2class();
    emit(output);
  }
}

class P2INPUTRAWDATA2class {
  P2INPUTRAWDATA2class({
    this.PO = '',
    this.SEQ = '',
    this.CPMAT = '',
    this.FGMAT = '',
    this.QTYT = '',
    this.UNIT = '',
    this.CUSTNA = '',
    this.PARTNA = '',
    this.PARTNO = '',
    this.PROC = '',
    this.CUSLOTNO = '',
    this.FG_CHARG = '',
    this.CUST_FULLNM = '',
  });

  String PO;
  String SEQ;
  String CPMAT;
  String FGMAT;
  String QTYT;
  String UNIT;
  String CUSTNA;
  String PARTNA;
  String PARTNO;
  String PROC;
  String CUSLOTNO;
  String FG_CHARG;
  String CUST_FULLNM;
}
