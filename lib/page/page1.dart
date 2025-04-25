import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/01-01-P1INPUTRAWDATA.dart';
import '../bloc/BlocEvent/01-02-GETINSTRUMENT.dart';
import '../bloc/BlocEvent/01-03-GETITEMS.dart';
import 'P1INPUTRAWDATA/P1INPUTRAWDATAMAIN.dart';

//---------------------------------------------------------

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page1BlocTableBody();
  }
}

class Page1BlocTableBody extends StatelessWidget {
  const Page1BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P1INPUTRAWDATA_Bloc(),
        child: BlocBuilder<P1INPUTRAWDATA_Bloc, P1INPUTRAWDATAclass>(
          builder: (context, data) {
            return Page1BlocTableBodyDD(
              data: data,
            );
          },
        ));
  }
}

class Page1BlocTableBodyDD extends StatelessWidget {
  Page1BlocTableBodyDD({
    Key? key,
    this.data,
  }) : super(key: key);
  P1INPUTRAWDATAclass? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GETINSTRUMENT_Bloc(),
        child: BlocBuilder<GETINSTRUMENT_Bloc, List<MapEntry<String, String>>>(
          builder: (context, dataDD) {
            return Page1BlocTableBodyDD2(
              dataDD: dataDD,
              data: data,
            );
          },
        ));
  }
}

class Page1BlocTableBodyDD2 extends StatelessWidget {
  Page1BlocTableBodyDD2({
    Key? key,
    this.data,
    this.dataDD,
  }) : super(key: key);
  P1INPUTRAWDATAclass? data;
  List<MapEntry<String, String>>? dataDD;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GETITEMS_Bloc(),
        child: BlocBuilder<GETITEMS_Bloc, List<MapEntry<String, String>>>(
          builder: (context, dataDD2) {
            return Page1Body(
              dataDD: dataDD,
              dataDD2: dataDD2,
              data: data,
            );
          },
        ));
  }
}

class Page1Body extends StatelessWidget {
  Page1Body({
    Key? key,
    this.data,
    this.dataDD,
    this.dataDD2,
  }) : super(key: key);
  P1INPUTRAWDATAclass? data;
  List<MapEntry<String, String>>? dataDD;
  List<MapEntry<String, String>>? dataDD2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: P1INPUTRAWDATAMAIN(
        data: data,
        dataDD: dataDD,
        dataDD2: dataDD2,
      ),
    );
  }
}
