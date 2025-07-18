import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../Layout/head.dart';
import '../../bloc/cubit/31-ReportPDFCommoncubit.dart';

import '../../data/global.dart';

import '../../widget/ReportComponent/CommonReport.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputText.dart';

import '../../widget/common/IMGviewWID.dart';
import '../../widget/common/Loading.dart';

import '../../widget/common/Safty.dart';
import '../../widget/function/helper.dart';
import '../../widget/newtable/REPORTSETtable.dart';
import 'ReportPDFCommonvar.dart';

late BuildContext ReportPDFCommoncontext;

class ReportPDFCommon extends StatefulWidget {
  ReportPDFCommon({
    Key? key,
    this.dataCommon,
  }) : super(key: key);
  CommonReportOutput? dataCommon;
  @override
  State<ReportPDFCommon> createState() => _ReportPDFCommonState();
}

class _ReportPDFCommonState extends State<ReportPDFCommon> {
  @override
  void initState() {
    ReportPDFCommonvar.PAGE = 1;
    ReportPDFCommonvar.TPKLOTEDIT = '';
    if (ReportPDFCommonvar.PO != '') {
      ReportPDFCommonvar.canf = false;
      // context
      //     .read<ReportPDFCommon_Cubit>()
      //     .ReportPDFCommonCubit(ReportPDFCommonvar.PO);
    }
    super.initState();
  }

  final GlobalKey _globalKey1 = GlobalKey();
  final GlobalKey _globalKey2 = GlobalKey();
  final GlobalKey _globalKey3 = GlobalKey();
  final GlobalKey _globalKey4 = GlobalKey();
  final GlobalKey _globalKey5 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ReportPDFCommoncontext = context;

    CommonReportOutput _dataCOMMON = widget.dataCommon ??
        CommonReportOutput(
          databasic: BasicCommonDATA(),
        );

    if (_dataCOMMON.datain.isNotEmpty) {
      //
      ReportPDFCommonvar.STATUS = 'REPORT READY';
      ReportPDFCommonvar.PO = _dataCOMMON.databasic.PO;
      ReportPDFCommonvar.CUSTOMER = _dataCOMMON.databasic.CUSTOMER;
      ReportPDFCommonvar.PROCESS = _dataCOMMON.databasic.PROCESS;
      ReportPDFCommonvar.PARTNAME = _dataCOMMON.databasic.PARTNAME;
      ReportPDFCommonvar.PARTNO = _dataCOMMON.databasic.PARTNO;
      ReportPDFCommonvar.CUSLOT = _dataCOMMON.databasic.CUSLOT;
      ReportPDFCommonvar.TPKLOT = _dataCOMMON.databasic.TPKLOT;
      ReportPDFCommonvar.MATERIAL = _dataCOMMON.databasic.MATERIAL;
      ReportPDFCommonvar.QTY =
          '${_dataCOMMON.databasic.QTY} ${_dataCOMMON.databasic.UNITSAP}';
    }

    print(_dataCOMMON.datain.length);

    if (_dataCOMMON.datain.length < 32) {
      ReportPDFCommonvar.PAGE = 1;
    } else if (_dataCOMMON.datain.length >= 32 &&
        _dataCOMMON.datain.length < 64) {
      ReportPDFCommonvar.PAGE = 2;
    } else if (_dataCOMMON.datain.length >= 64) {
      ReportPDFCommonvar.PAGE = 3;
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ComInputText(
                  height: 40,
                  width: 200,
                  isContr: ReportPDFCommonvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFCommonvar.iscontrol = input;
                    });
                  },
                  isEnabled: ReportPDFCommonvar.canf,
                  sValue: ReportPDFCommonvar.PO,
                  returnfunc: (String s) {
                    ReportPDFCommonvar.PO = s;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    if (ReportPDFCommonvar.PO != '') {
                      context
                          .read<ReportPDFCommon_Cubit>()
                          .ReportPDFCommonCubit(ReportPDFCommonvar.PO);
                    }
                  },
                  child: Container(
                    color: Colors.black,
                    height: 40,
                    width: 40,
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: () {
                    context.read<ReportPDFCommon_Cubit>().Flush();
                    ReportPDFCommonvar.canf = true;
                    ReportPDFCommonvar.iscontrol = true;
                    ReportPDFCommonvar.PO = '';
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.red,
                    height: 40,
                    width: 100,
                    child: const Center(
                      child: Text("CLEAR"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  color: ReportPDFCommonvar.STATUS == 'REPORT READY'
                      ? Colors.green
                      : Colors.yellow,
                  height: 40,
                  width: 200,
                  child: Center(
                    child: Text(ReportPDFCommonvar.STATUS),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: ComInputText(
                  height: 40,
                  width: 200,
                  isContr: ReportPDFCommonvar.iscontrol,
                  fnContr: (input) {
                    setState(() {
                      ReportPDFCommonvar.iscontrol = input;
                    });
                  },
                  sPlaceholder: "Inspected By",
                  sValue: ReportPDFCommonvar.SignInsBy,
                  returnfunc: (String s) {
                    setState(() {
                      ReportPDFCommonvar.SignInsBy = s;
                    });
                  },
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  PDFloader(context);
                  Future.delayed(const Duration(milliseconds: 1000), () {
                    // capture(
                    // captureToback(
                    // capture(
                    //   _globalKey1,
                    //   ReportPDFCommonvar.PO,
                    // ).then((value) {
                    //   print(value);
                    //   Navigator.pop(context);
                    // });
                    if (ReportPDFCommonvar.PAGE == 1) {
                      // capture(
                      // captureToback(
                      captureToback(
                        _globalKey1,
                        ReportPDFCommonvar.PO,
                      ).then((value) {
                        print(value);
                        Navigator.pop(context);
                      });
                    } else if (ReportPDFCommonvar.PAGE == 2) {
                      // capture(
                      // captureToback(
                      capture2(
                        _globalKey1,
                        _globalKey2,
                        ReportPDFCommonvar.PO,
                      ).then((value) {
                        print(value);
                        Navigator.pop(context);
                      });
                    } else {
                      capture3(
                        _globalKey1,
                        _globalKey2,
                        _globalKey3,
                        ReportPDFCommonvar.PO,
                      ).then((value) {
                        print(value);
                        Navigator.pop(context);
                      });
                    }
                  });
                },
                child: Container(
                  color: Colors.yellow,
                  height: 50,
                  width: 100,
                  child: const Center(
                    child: Text("Print"),
                  ),
                ),
              )
            ],
          ),
          // Row(children: [
          //   Padding(
          //     padding: const EdgeInsets.all(3.0),
          //     child: InkWell(
          //       onTap: () {
          //         // P303QMMASTERQCVAR.SETDAY = 'OK';
          //         // P303QMMASTERQCVAR.SEARCH = ReportPDFCommonvar.PO;
          //         // var now = DateTime.now().subtract(Duration(days: 25));
          //         // P303QMMASTERQCVAR.day = DateFormat('dd').format(now);
          //         // P303QMMASTERQCVAR.month = DateFormat('MM').format(now);
          //         // P303QMMASTERQCVAR.year = DateFormat('yyyy').format(now);
          //         // STDreport2(context);
          //       },
          //       child: Container(
          //         color: Colors.yellow,
          //         height: 50,
          //         width: 100,
          //         child: const Center(
          //           child: Text("UD and QCFN"),
          //         ),
          //       ),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(3.0),
          //     child: InkWell(
          //       onTap: () {
          //         //ReportPDFCommonvar.PO
          //         QCFN(context);
          //       },
          //       child: Container(
          //         color: Colors.yellow,
          //         height: 50,
          //         width: 100,
          //         child: const Center(
          //           child: Text("QCFN"),
          //         ),
          //       ),
          //     ),
          //   ),
          //   Padding(
          //     padding: const EdgeInsets.all(3.0),
          //     child: InkWell(
          //       onTap: () {
          //         //ReportPDFCommonvar.PO
          //         String server = 'http://172.23.10.40:1885/';
          //         String sap = "sap_GASHES_GB";

          //         Dio().post(
          //           server + sap,
          //           data: {},
          //         ).then((v) {
          //           //
          //           var databuff = v.data;
          //           for (var i = 0; i < databuff.length; i++) {
          //             //

          //             if (databuff[i]['PO'] == ReportPDFCommonvar.PO) {
          //               print(
          //                   databuff[i]['PO'] + ':' + databuff[i]['FG_CHARG']);
          //               // print(databuff[i]);
          //               ReportPDFCommonvar.TPKLOTEDIT = databuff[i]['FG_CHARG'];
          //               setState(() {});
          //             }
          //           }
          //         });
          //       },
          //       child: Container(
          //         color: Colors.orange,
          //         height: 50,
          //         width: 100,
          //         child: const Center(
          //           child: Text("Re Lot"),
          //         ),
          //       ),
          //     ),
          //   ),
          // ]),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: RepaintBoundary(
              key: _globalKey1,
              child: Column(
                children: [
                  Row(
                    children: [
                      // const SizedBox(
                      //   width: 50,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          // height: _dataCOMMON.datain.length > 30 ? 3000 : 2000,
                          // width: 1364,
                          height: 1900,
                          width: 1364,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 3),
                            // color: Colors.red,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                          ),
                          child: Column(
                            children: [
                              headerreport(
                                page: "1/" + ReportPDFCommonvar.PAGE.toString(),
                                ORDER: ReportPDFCommonvar.PO,
                                CUSTOMER: ReportPDFCommonvar.CUSTOMER,
                                PROCESS: ReportPDFCommonvar.PROCESS,
                                PARTNAME: ReportPDFCommonvar.PARTNO,
                                PARTNO: "",
                                CUSLOT: ReportPDFCommonvar.CUSLOT,
                                TPKLOT: ReportPDFCommonvar.TPKLOT,
                                MATERIAL: ReportPDFCommonvar.MATERIAL,
                                QTY: ReportPDFCommonvar.QTY,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    FINISHEDGOODTRANFERHStable(),
                                    if (_dataCOMMON.datain.length >= 32) ...[
                                      for (int i = 0;
                                          // i < _dataCOMMON.datain.length;
                                          i < 32;
                                          i++) ...[
                                        //
                                        FINISHEDGOODTRANFERHSitem(
                                          text01: _dataCOMMON.datain[i].date,
                                          text02: _dataCOMMON.datain[i].TYPE,
                                          text03: (int.parse(ConverstStr(
                                                  _dataCOMMON
                                                      .datain[i].NUMBER)))
                                              .toString(),
                                          text04: (int.parse(ConverstStr(
                                                      _dataCOMMON
                                                          .datain[i].POINT)) +
                                                  1)
                                              .toString(),
                                          text05: _dataCOMMON.datain[i].Data,
                                          text06: _dataCOMMON.datain[i].SP01,
                                          pic: _dataCOMMON.datain[i].Picture ==
                                              '',
                                          Wid01: PicShow(
                                            width: 75,
                                            height: 75,
                                            base64:
                                                _dataCOMMON.datain[i].Picture,
                                          ),
                                        )
                                      ],
                                    ] else ...[
                                      for (int i = 0;
                                          i < _dataCOMMON.datain.length;
                                          // i < 30;
                                          i++) ...[
                                        //
                                        FINISHEDGOODTRANFERHSitem(
                                          text01: _dataCOMMON.datain[i].date,
                                          text02: _dataCOMMON.datain[i].TYPE,
                                          text03: (int.parse(ConverstStr(
                                                  _dataCOMMON
                                                      .datain[i].NUMBER)))
                                              .toString(),
                                          text04: (int.parse(ConverstStr(
                                                      _dataCOMMON
                                                          .datain[i].POINT)) +
                                                  1)
                                              .toString(),
                                          text05: _dataCOMMON.datain[i].Data,
                                          text06: _dataCOMMON.datain[i].SP01,
                                          pic: _dataCOMMON.datain[i].Picture ==
                                              '',
                                          Wid01: PicShow(
                                            width: 75,
                                            height: 75,
                                            base64:
                                                _dataCOMMON.datain[i].Picture,
                                          ),
                                        )
                                      ],
                                    ],
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_dataCOMMON.datain.length >= 32) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RepaintBoundary(
                key: _globalKey2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // const SizedBox(
                        //   width: 50,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            // height: _dataCOMMON.datain.length > 30 ? 3000 : 2000,
                            // width: 1364,
                            height: 1900,
                            width: 1364,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              // color: Colors.red,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0)),
                            ),
                            child: Column(
                              children: [
                                headerreport(
                                  page:
                                      "2/" + ReportPDFCommonvar.PAGE.toString(),
                                  ORDER: ReportPDFCommonvar.PO,
                                  CUSTOMER: ReportPDFCommonvar.CUSTOMER,
                                  PROCESS: ReportPDFCommonvar.PROCESS,
                                  PARTNAME: ReportPDFCommonvar.PARTNO,
                                  PARTNO: "",
                                  CUSLOT: ReportPDFCommonvar.CUSLOT,
                                  TPKLOT: ReportPDFCommonvar.TPKLOT,
                                  MATERIAL: ReportPDFCommonvar.MATERIAL,
                                  QTY: ReportPDFCommonvar.QTY,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      FINISHEDGOODTRANFERHStable(),
                                      if (_dataCOMMON.datain.length >= 64) ...[
                                        for (int i = 32;
                                            // i < _dataCOMMON.datain.length;
                                            i < 64;
                                            i++) ...[
                                          //
                                          FINISHEDGOODTRANFERHSitem(
                                            text01: _dataCOMMON.datain[i].date,
                                            text02: _dataCOMMON.datain[i].TYPE,
                                            text03: (int.parse(ConverstStr(
                                                    _dataCOMMON
                                                        .datain[i].NUMBER)))
                                                .toString(),
                                            text04: (int.parse(ConverstStr(
                                                        _dataCOMMON
                                                            .datain[i].POINT)) +
                                                    1)
                                                .toString(),
                                            text05: _dataCOMMON.datain[i].Data,
                                            text06: _dataCOMMON.datain[i].SP01,
                                            pic:
                                                _dataCOMMON.datain[i].Picture ==
                                                    '',
                                            Wid01: PicShow(
                                              width: 75,
                                              height: 75,
                                              base64:
                                                  _dataCOMMON.datain[i].Picture,
                                            ),
                                          )
                                        ],
                                      ] else ...[
                                        for (int i = 32;
                                            i < _dataCOMMON.datain.length;
                                            // i < 30;
                                            i++) ...[
                                          //
                                          FINISHEDGOODTRANFERHSitem(
                                            text01: _dataCOMMON.datain[i].date,
                                            text02: _dataCOMMON.datain[i].TYPE,
                                            text03: (int.parse(ConverstStr(
                                                    _dataCOMMON
                                                        .datain[i].NUMBER)))
                                                .toString(),
                                            text04: (int.parse(ConverstStr(
                                                        _dataCOMMON
                                                            .datain[i].POINT)) +
                                                    1)
                                                .toString(),
                                            text05: _dataCOMMON.datain[i].Data,
                                            text06: _dataCOMMON.datain[i].SP01,
                                            pic:
                                                _dataCOMMON.datain[i].Picture ==
                                                    '',
                                            Wid01: PicShow(
                                              width: 75,
                                              height: 75,
                                              base64:
                                                  _dataCOMMON.datain[i].Picture,
                                            ),
                                          )
                                        ],
                                      ],
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
          if (_dataCOMMON.datain.length >= 64) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RepaintBoundary(
                key: _globalKey3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        // const SizedBox(
                        //   width: 50,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            // height: _dataCOMMON.datain.length > 30 ? 3000 : 2000,
                            // width: 1364,
                            height: 1900,
                            width: 1364,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 3),
                              // color: Colors.red,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(0)),
                            ),
                            child: Column(
                              children: [
                                headerreport(
                                  page:
                                      "3/" + ReportPDFCommonvar.PAGE.toString(),
                                  ORDER: ReportPDFCommonvar.PO,
                                  CUSTOMER: ReportPDFCommonvar.CUSTOMER,
                                  PROCESS: ReportPDFCommonvar.PROCESS,
                                  PARTNAME: ReportPDFCommonvar.PARTNO,
                                  PARTNO: "",
                                  CUSLOT: ReportPDFCommonvar.CUSLOT,
                                  TPKLOT: ReportPDFCommonvar.TPKLOT,
                                  MATERIAL: ReportPDFCommonvar.MATERIAL,
                                  QTY: ReportPDFCommonvar.QTY,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      FINISHEDGOODTRANFERHStable(),
                                      if (_dataCOMMON.datain.length >= 96) ...[
                                        for (int i = 64;
                                            // i < _dataCOMMON.datain.length;
                                            i < 105;
                                            i++) ...[
                                          //
                                          FINISHEDGOODTRANFERHSitem(
                                            text01: _dataCOMMON.datain[i].date,
                                            text02: _dataCOMMON.datain[i].TYPE,
                                            text03: (int.parse(ConverstStr(
                                                    _dataCOMMON
                                                        .datain[i].NUMBER)))
                                                .toString(),
                                            text04: (int.parse(ConverstStr(
                                                        _dataCOMMON
                                                            .datain[i].POINT)) +
                                                    1)
                                                .toString(),
                                            text05: _dataCOMMON.datain[i].Data,
                                            text06: _dataCOMMON.datain[i].SP01,
                                            pic:
                                                _dataCOMMON.datain[i].Picture ==
                                                    '',
                                            Wid01: PicShow(
                                              width: 75,
                                              height: 75,
                                              base64:
                                                  _dataCOMMON.datain[i].Picture,
                                            ),
                                          )
                                        ],
                                      ] else ...[
                                        for (int i = 64;
                                            i < _dataCOMMON.datain.length;
                                            // i < 30;
                                            i++) ...[
                                          //
                                          FINISHEDGOODTRANFERHSitem(
                                            text01: _dataCOMMON.datain[i].date,
                                            text02: _dataCOMMON.datain[i].TYPE,
                                            text03: (int.parse(ConverstStr(
                                                    _dataCOMMON
                                                        .datain[i].NUMBER)))
                                                .toString(),
                                            text04: (int.parse(ConverstStr(
                                                        _dataCOMMON
                                                            .datain[i].POINT)) +
                                                    1)
                                                .toString(),
                                            text05: _dataCOMMON.datain[i].Data,
                                            text06: _dataCOMMON.datain[i].SP01,
                                            pic:
                                                _dataCOMMON.datain[i].Picture ==
                                                    '',
                                            Wid01: PicShow(
                                              width: 75,
                                              height: 75,
                                              base64:
                                                  _dataCOMMON.datain[i].Picture,
                                            ),
                                          )
                                        ],
                                      ],
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          Container(
            height: 50,
          ),
        ],
      ),
    );
  }
}

List<int> S16slot = const [
  3,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1
];

void STDreport2(
  BuildContext contextin,
) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 1000,
          width: 1500,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
                // child: Page303(),
                ),
          ),
        ),
      );
    },
  );
}

void QCFN(BuildContext contextin) {
  showDialog(
    context: contextin,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        child: QCFNWD(),
      );
    },
  );
}

class QCFNWD extends StatefulWidget {
  const QCFNWD({super.key});

  @override
  State<QCFNWD> createState() => QCFNWDState();
}

class QCFNWDState extends State<QCFNWD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 600,
      child: Center(
        child: SizedBox(
          child: InkWell(
            onTap: () {
              // print("00" + ReportPDFCommonvar.PO);
              // Dio().post(
              //   "${server2}10GETDATAFROMJOBBINGAQC/QCFN",
              //   // "${'http://127.0.0.1:14094/'}10GETDATAFROMJOBBINGAQC/QCFN",
              //   data: {
              //     "BAPI_NAME": "ZFMPPQCFN_IN",
              //     "ORDERID": ReportPDFCommonvar.PO,
              //     "PERNR_ID": USERDATA.ID
              //   },
              // ).then((v) {
              //   Navigator.pop(context);

              //   //
              //   print(v.data);
              //   if (v.data['ExportParameter'] != null) {
              //     if (v.data['ExportParameter']['INACT_NEW'].toString() ==
              //         'E') {
              //       showErrorPopup(context, v.data.toString());
              //     } else {
              //       showGoodPopup(context, v.data.toString());
              //     }
              //   } else {
              //     showErrorPopup(context, v.data.toString());
              //   }
              // });
            },
            child: Container(
              width: 400,
              height: 100,
              color: Colors.blue,
              child: Center(
                child: Text("QCFN"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
