import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P2INPUTRAWDATA2/P2INPUTRAWDATA2VAR.dart';

//-------------------------------------------------

abstract class GETITEMS_Event {}

class GETITEMS_GET extends GETITEMS_Event {}

class GETITEMS_flush extends GETITEMS_Event {}

class GETITEMS_Bloc
    extends Bloc<GETITEMS_Event, List<MapEntry<String, String>>> {
  GETITEMS_Bloc() : super([]) {
    on<GETITEMS_GET>((event, emit) {
      return _GETITEMS_GET([], emit);
    });
    on<GETITEMS_flush>((event, emit) {
      return _GETITEMS_flush([], emit);
    });
  }
  Future<void> _GETITEMS_GET(List<MapEntry<String, String>> toAdd,
      Emitter<List<MapEntry<String, String>>> emit) async {
    List<MapEntry<String, String>> output = [MapEntry("", "")];

    print("-------------->");
    print(P2INPUTRAWDATA2MAINVAR.LOCATION + P2INPUTRAWDATA2MAINVAR.PLANT);
    final response = await Dio().post(
      GLOserverRAW + 'RAWDATA/Getitemslist',
      data: {
        "PLANT": P2INPUTRAWDATA2MAINVAR.LOCATION + P2INPUTRAWDATA2MAINVAR.PLANT,
        "CP": P2INPUTRAWDATA2MAINVAR.CPGET,
        "PCDATA": P2INPUTRAWDATA2MAINVAR.SPCdata,
        "PCDATAL": P2INPUTRAWDATA2MAINVAR.SPC
      },
    );

    // print(response.statusCode);

    if (response.statusCode == 200) {
      var databuff = response.data;

      print(databuff);
      if (databuff.length > 0) {
        //
        for (var i = 0; i < databuff.length; i++) {
          output.add(
              MapEntry(databuff[i]['ItemsName'], databuff[i]['ItemsName']));
        }
      }
    }
    emit(output);
  }

  Future<void> _GETITEMS_flush(List<MapEntry<String, String>> toAdd,
      Emitter<List<MapEntry<String, String>>> emit) async {
    List<MapEntry<String, String>> output = [];

    emit(output);
  }
}
