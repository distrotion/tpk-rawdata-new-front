import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P1INPUTRAWDATA/P1INPUTRAWDATAMAINVAR.dart';

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
    final response = await Dio().post(
      GLOserverRAW + 'RAWDATA/Getitemslist',
      data: {
        "PLANT": P1INPUTRAWDATAMAINVAR.LOCATION + P1INPUTRAWDATAMAINVAR.PLANT,
        "CP": P1INPUTRAWDATAMAINVAR.CPGET,
        "PCDATA": P1INPUTRAWDATAMAINVAR.SPCdata,
        "PCDATAL": P1INPUTRAWDATAMAINVAR.SPC
      },
    );
    if (response.statusCode == 200) {
      var databuff = response.data;
      print(databuff);
      if (databuff.length > 0) {
        //
        for (var i = 0; i < databuff.length; i++) {
          output.add(MapEntry(databuff[i]['ItemsName'], databuff[i]['Items']));
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
