import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/BlocEvent/02-01-P2INPUTRAWDATA2.dart';
import '../bloc/BlocEvent/02-02-GETINSTRUMENT2.dart';
import '../bloc/BlocEvent/02-03-GETITEMS2.dart';
import 'P2INPUTRAWDATA2/P2INPUTRAWDATA2MAIN.dart';

//---------------------------------------------------------

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Page2BlocTableBody();
  }
}

class Page2BlocTableBody extends StatelessWidget {
  const Page2BlocTableBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => P2INPUTRAWDATA2_Bloc(),
        child: BlocBuilder<P2INPUTRAWDATA2_Bloc, P2INPUTRAWDATA2class>(
          builder: (context, data) {
            return Page2BlocTableBodyDD(
              data: data,
            );
          },
        ));
  }
}

class Page2BlocTableBodyDD extends StatelessWidget {
  Page2BlocTableBodyDD({
    Key? key,
    this.data,
  }) : super(key: key);
  P2INPUTRAWDATA2class? data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GETINSTRUMENT_Bloc(),
        child: BlocBuilder<GETINSTRUMENT_Bloc, List<MapEntry<String, String>>>(
          builder: (context, dataDD) {
            return Page2BlocTableBodyDD2(
              dataDD: dataDD,
              data: data,
            );
          },
        ));
  }
}

class Page2BlocTableBodyDD2 extends StatelessWidget {
  Page2BlocTableBodyDD2({
    Key? key,
    this.data,
    this.dataDD,
  }) : super(key: key);
  P2INPUTRAWDATA2class? data;
  List<MapEntry<String, String>>? dataDD;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => GETITEMS_Bloc(),
        child: BlocBuilder<GETITEMS_Bloc, List<MapEntry<String, String>>>(
          builder: (context, dataDD2) {
            return Page2Body(
              dataDD: dataDD,
              dataDD2: dataDD2,
              data: data,
            );
          },
        ));
  }
}

class Page2Body extends StatelessWidget {
  Page2Body({
    Key? key,
    this.data,
    this.dataDD,
    this.dataDD2,
  }) : super(key: key);
  P2INPUTRAWDATA2class? data;
  List<MapEntry<String, String>>? dataDD;
  List<MapEntry<String, String>>? dataDD2;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: P2INPUTRAWDATA2MAIN(
        data: data,
        dataDD: dataDD,
        dataDD2: dataDD2,
      ),
    );
  }
}
