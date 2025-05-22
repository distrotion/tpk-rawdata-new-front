import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1INPUTRAWDATA/P1INPUTRAWDATAMAIN.dart';
import '../../page/P1INPUTRAWDATA/P1INPUTRAWDATAMAINVAR.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/Safty.dart';
import '01-03-GETITEMS.dart';

//-------------------------------------------------

abstract class P1INPUTRAWDATA_Event {}

class P1INPUTRAWDATA_GET extends P1INPUTRAWDATA_Event {}

class P1INPUTRAWDATA_SET extends P1INPUTRAWDATA_Event {}

class P1INPUTRAWDATA_Bloc
    extends Bloc<P1INPUTRAWDATA_Event, P1INPUTRAWDATAclass> {
  P1INPUTRAWDATA_Bloc() : super(P1INPUTRAWDATAclass()) {
    on<P1INPUTRAWDATA_GET>((event, emit) {
      return _P1INPUTRAWDATA_GET(P1INPUTRAWDATAclass(), emit);
    });
    on<P1INPUTRAWDATA_SET>((event, emit) {
      return _P1INPUTRAWDATA_SET(P1INPUTRAWDATAclass(), emit);
    });
  }
  Future<void> _P1INPUTRAWDATA_GET(
      P1INPUTRAWDATAclass toAdd, Emitter<P1INPUTRAWDATAclass> emit) async {
    P1INPUTRAWDATAclass output = P1INPUTRAWDATAclass();
    FreeLoading(P1INPUTRAWDATAMAINcontext);
    final response = await Dio().post(
      // GLOserverRAW + 'RAWDATA/sapget',
      "http://172.23.10.40:1885/${P1INPUTRAWDATAMAINVAR.LINKPLANT}",
      data: {
        "ORDER": P1INPUTRAWDATAMAINVAR.ORDER,
      },
    );

    if (response.statusCode == 200) {
      var databuff = response.data;
      print(databuff);
      if (databuff.length > 0) {
        //
        output.PO = P1INPUTRAWDATAMAINVAR.ORDER;
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
        P1INPUTRAWDATAMAINVAR.CPGET =
            int.parse(ConverstStr(output.CPMAT)).toString();
      }
    } else {
      //
    }

    // print(P1INPUTRAWDATAMAINVAR.CPGET);
    Navigator.pop(P1INPUTRAWDATAMAINcontext);
    if (output.CPMAT.length > 6) {}

    P1INPUTRAWDATAMAINcontext.read<GETITEMS_Bloc>().add(GETITEMS_GET());
    emit(output);
  }

  Future<void> _P1INPUTRAWDATA_SET(
      P1INPUTRAWDATAclass toAdd, Emitter<P1INPUTRAWDATAclass> emit) async {
    P1INPUTRAWDATAclass output = P1INPUTRAWDATAclass();
    emit(output);
  }
}

class P1INPUTRAWDATAclass {
  P1INPUTRAWDATAclass({
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
