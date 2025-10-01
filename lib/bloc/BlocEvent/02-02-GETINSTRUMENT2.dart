import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/global.dart';
import '../../page/P2INPUTRAWDATA2/P2INPUTRAWDATA2VAR.dart';

//-------------------------------------------------

abstract class GETINSTRUMENT_Event {}

class GETINSTRUMENT_GET extends GETINSTRUMENT_Event {}

class GETINSTRUMENT_flush extends GETINSTRUMENT_Event {}

class GETINSTRUMENT_Bloc
    extends Bloc<GETINSTRUMENT_Event, List<MapEntry<String, String>>> {
  GETINSTRUMENT_Bloc() : super([]) {
    on<GETINSTRUMENT_GET>((event, emit) {
      return _GETINSTRUMENT_GET([], emit);
    });
    on<GETINSTRUMENT_flush>((event, emit) {
      return _GETINSTRUMENT_flush([], emit);
    });
  }
  Future<void> _GETINSTRUMENT_GET(List<MapEntry<String, String>> toAdd,
      Emitter<List<MapEntry<String, String>>> emit) async {
    List<MapEntry<String, String>> output = [MapEntry("", "")];
    final response = await Dio().post(
      GLOserverRAW + 'RAWDATA/Getinstrument',
      data: {
        "PLANT": P2INPUTRAWDATA2MAINVAR.LOCATION + P2INPUTRAWDATA2MAINVAR.PLANT,
      },
    );
    if (response.statusCode == 200) {
      var databuff = response.data;
      // print(databuff);
      if (databuff.length > 0) {
        //
        for (var i = 0; i < databuff.length; i++) {
          output.add(MapEntry(databuff[i]['value'], databuff[i]['value']));
        }
      }
    }
    emit(output);
  }

  Future<void> _GETINSTRUMENT_flush(List<MapEntry<String, String>> toAdd,
      Emitter<List<MapEntry<String, String>>> emit) async {
    List<MapEntry<String, String>> output = [];

    emit(output);
  }
}
