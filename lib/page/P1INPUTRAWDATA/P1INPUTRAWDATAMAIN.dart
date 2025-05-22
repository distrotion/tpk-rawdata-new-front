import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as IMG;

import '../../bloc/BlocEvent/01-01-P1INPUTRAWDATA.dart';
import '../../bloc/BlocEvent/01-02-GETINSTRUMENT.dart';
import '../../bloc/BlocEvent/01-03-GETITEMS.dart';
import '../../data/global.dart';
import '../../model/model.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/IMGviewWID.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/Safty.dart';
import '../../widget/newtable/tablebox.dart';
import 'P1INPUTRAWDATAMAINVAR.dart';

late BuildContext P1INPUTRAWDATAMAINcontext;

class P1INPUTRAWDATAMAIN extends StatefulWidget {
  P1INPUTRAWDATAMAIN({
    super.key,
    this.data,
    this.dataDD,
    this.dataDD2,
  });
  P1INPUTRAWDATAclass? data;
  List<MapEntry<String, String>>? dataDD;
  List<MapEntry<String, String>>? dataDD2;
  @override
  State<P1INPUTRAWDATAMAIN> createState() => _P1INPUTRAWDATAMAINState();
}

class _P1INPUTRAWDATAMAINState extends State<P1INPUTRAWDATAMAIN> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    P1INPUTRAWDATAMAINVAR.NUMBER = '1';
    P1INPUTRAWDATAMAINVAR.POINT = '0';
    P1INPUTRAWDATAMAINVAR.tabledata = [];
    P1INPUTRAWDATAMAINVAR.AUTOGET == '';
  }

  @override
  void dispose() {
    super.dispose();

    P1INPUTRAWDATAMAINVAR.DHtimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    P1INPUTRAWDATAMAINcontext = context;
    P1INPUTRAWDATAclass _data = widget.data ?? P1INPUTRAWDATAclass();
    List<MapEntry<String, String>> _dataDD = widget.dataDD ?? [];
    List<MapEntry<String, String>> _dataDD2 = widget.dataDD2 ?? [];
    // if (_dataDD.isNotEmpty) {
    //   P1INPUTRAWDATAMAINVAR.INSTRUMENTlist = _dataDD;
    // }
    if (_dataDD2.isNotEmpty) {
      P1INPUTRAWDATAMAINVAR.ITEMslist = _dataDD2;
    }

    if (P1INPUTRAWDATAMAINVAR.AUTOGET == 'auto') {
      P1INPUTRAWDATAMAINVAR.DHtimer = Timer(const Duration(seconds: 1), () {
        //
        Dio().post(
          "http://172.23.10.40:1900/" + "getdata",
          data: {
            "INS": P1INPUTRAWDATAMAINVAR.INSTRUMENT,
            "NO": P1INPUTRAWDATAMAINVAR.POINT,
            "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
            "LOCATION": P1INPUTRAWDATAMAINVAR.LOCATION,
            "PLANT": P1INPUTRAWDATAMAINVAR.PLANT,
          },
        ).then((v) {
          var databuff = v.data;
          // print(databuff);
          if (databuff['DATA'] != null) {
            P1INPUTRAWDATAMAINVAR.DATASET = databuff['DATA'].toString();
            setState(() {});
          }
        });
      });
    }

    return Container(
      height: 600,
      width: 900,
      // color: Colors.red,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: AdvanceDropDown(
                    isEnable: P1INPUTRAWDATAMAINVAR.PLANT != '',
                    sLabel: "Select Loacation",
                    imgpath: '',
                    listdropdown: const [
                      MapEntry("", ""),
                      MapEntry("BP12", "BP12"),
                      MapEntry("GW", "GW"),
                      MapEntry("HES", "HES"),
                    ],
                    onChangeinside: (d, v) {
                      P1INPUTRAWDATAMAINVAR.LOCATION = d;

                      if (P1INPUTRAWDATAMAINVAR.LOCATION == 'BP12') {
                        P1INPUTRAWDATAMAINVAR.LINKPLANT = 'getitem2100';
                        P1INPUTRAWDATAMAINVAR.Plantlist =
                            P1INPUTRAWDATAMAINVAR.plantBP12;
                      } else if (P1INPUTRAWDATAMAINVAR.LOCATION == 'GW') {
                        P1INPUTRAWDATAMAINVAR.LINKPLANT = 'getitem2200';
                        P1INPUTRAWDATAMAINVAR.Plantlist =
                            P1INPUTRAWDATAMAINVAR.plantGW;
                      } else if (P1INPUTRAWDATAMAINVAR.LOCATION == 'HES') {
                        P1INPUTRAWDATAMAINVAR.LINKPLANT = 'getitem2300';
                        P1INPUTRAWDATAMAINVAR.Plantlist =
                            P1INPUTRAWDATAMAINVAR.plantHES;
                      } else {
                        P1INPUTRAWDATAMAINVAR.Plantlist =
                            P1INPUTRAWDATAMAINVAR.blank;
                      }
                      setState(() {});
                    },
                    value: P1INPUTRAWDATAMAINVAR.LOCATION,
                    height: 40,
                    width: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: AdvanceDropDown(
                    sLabel: "Plant",
                    imgpath: '',
                    isEnable: P1INPUTRAWDATAMAINVAR.PLANT != '',
                    listdropdown: P1INPUTRAWDATAMAINVAR.Plantlist,
                    onChangeinside: (d, v) {
                      setState(() {
                        P1INPUTRAWDATAMAINVAR.PLANT = d;
                      });

                      // context
                      //     .read<GETINSTRUMENT_Bloc>()
                      //     .add(GETINSTRUMENT_GET());

                      if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'BP12GAS') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.BP12GAS;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'BP12PH') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.BP12PH;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'BP12PAL') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.BP12PAL;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'BP12PVD') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.BP12PVD;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'BP12KNG') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.BP12KNG;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'GWGAS') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.GWGAS;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'HESGAS') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.HESGAS;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'HESPH') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.HESPH;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'HESDEL') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.HESDEL;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'HESPAL') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.HESPAL;
                      } else if ((P1INPUTRAWDATAMAINVAR.LOCATION +
                              P1INPUTRAWDATAMAINVAR.PLANT) ==
                          'HESISN') {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENTlist =
                            P1INPUTRAWDATAMAINVAR.HESISN;
                      }
                      setState(() {});
                    },
                    value: P1INPUTRAWDATAMAINVAR.PLANT,
                    height: 40,
                    width: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: AdvanceDropDown(
                    isEnable: P1INPUTRAWDATAMAINVAR.SPCdata != '',
                    sLabel: "INSPCETION TYPE",
                    imgpath: '',
                    listdropdown: P1INPUTRAWDATAMAINVAR.SPClist,
                    onChangeinside: (d, v) {
                      setState(() {
                        P1INPUTRAWDATAMAINVAR.SPCdata = d;
                        P1INPUTRAWDATAMAINVAR.SPC = v;
                      });
                    },
                    value: P1INPUTRAWDATAMAINVAR.SPCdata,
                    height: 40,
                    width: 200,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: AdvanceDropDown(
                    sLabel: "INSTRUMENT",
                    imgpath: '',
                    listdropdown: P1INPUTRAWDATAMAINVAR.INSTRUMENTlist,
                    onChangeinside: (d, v) {
                      setState(() {
                        P1INPUTRAWDATAMAINVAR.INSTRUMENT = d;
                      });
                    },
                    value: P1INPUTRAWDATAMAINVAR.INSTRUMENT,
                    height: 40,
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 80,
                      width: 150,
                      child: ComInputText(
                        // isNumberOnly: true,
                        isEnabled: _data.CUST_FULLNM == '',
                        sLabel: "ORDER",
                        height: 40,
                        width: 250,
                        isContr: P1INPUTRAWDATAMAINVAR.iscontrol,
                        fnContr: (input) {
                          setState(() {
                            P1INPUTRAWDATAMAINVAR.iscontrol = input;
                          });
                        },
                        sValue: P1INPUTRAWDATAMAINVAR.ORDER,
                        returnfunc: (String s) {
                          P1INPUTRAWDATAMAINVAR.ORDER = s;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      if (_data.CUSTNA == '') {
                        P1INPUTRAWDATAMAINVAR.tabledata = [];
                        if (P1INPUTRAWDATAMAINVAR.LOCATION != '' &&
                            P1INPUTRAWDATAMAINVAR.PLANT != '' &&
                            P1INPUTRAWDATAMAINVAR.SPCdata != '' &&
                            P1INPUTRAWDATAMAINVAR.SPC != '') {
                          context
                              .read<P1INPUTRAWDATA_Bloc>()
                              .add(P1INPUTRAWDATA_GET());

                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdataall",
                            data: {
                              "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                              "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                              "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              P1INPUTRAWDATAMAINVAR.NUMBER =
                                  databuff[0]['NUMBER'];
                              P1INPUTRAWDATAMAINVAR.POINT =
                                  databuff[0]['POINT'];
                              Dio().post(
                                GLOserverRAW + "RAWDATA/getdata",
                                data: {
                                  "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                                  "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                                  "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                // print(databuff);
                                if (databuff.length > 0) {
                                  // print(databuff);
                                  setState(() {});
                                  for (var i = 0; i < databuff.length; i++) {
                                    //
                                    P1INPUTRAWDATAMAINVAR.tabledata.add(
                                        TABLECLASSclass(
                                            // NO: (i + 1).toString(),
                                            NO: (databuff.length - i)
                                                .toString(),
                                            DATA: databuff[i]['Data']));
                                  }

                                  P1INPUTRAWDATAMAINVAR.POINT =
                                      (databuff.length).toString();
                                } else {
                                  P1INPUTRAWDATAMAINVAR.tabledata = [];
                                  setState(() {});
                                }
                              });
                            }
                          });
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      color: P1INPUTRAWDATAMAINVAR.LOCATION != '' &&
                              P1INPUTRAWDATAMAINVAR.PLANT != '' &&
                              P1INPUTRAWDATAMAINVAR.SPCdata != '' &&
                              P1INPUTRAWDATAMAINVAR.SPC != '' &&
                              _data.CUSTNA == ''
                          ? Colors.blue
                          : Colors.grey,
                      child: Center(
                        child: Text("SELECT"),
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          // Container(
                          //   height: 40,
                          //   width: 100,
                          //   color: Colors.green,
                          //   child: Center(
                          //     child: Text(
                          //         "NUMBER : ${int.parse(P1INPUTRAWDATAMAINVAR.NUMBER) + 1}"),
                          //   ),
                          // ),
                          AdvanceDropDown(
                        imgpath: '',
                        sLabel: "NUMBER",
                        listdropdown: const [
                          MapEntry("", ""),
                          MapEntry("1", "1"),
                          MapEntry("2", "2"),
                          MapEntry("3", "3"),
                          MapEntry("4", "4"),
                          MapEntry("5", "5"),
                          MapEntry("6", "6"),
                          MapEntry("7", "7"),
                          MapEntry("8", "8"),
                          MapEntry("9", "9"),
                          MapEntry("10", "10"),
                          MapEntry("11", "11"),
                          MapEntry("12", "12"),
                          MapEntry("13", "13"),
                          MapEntry("14", "14"),
                          MapEntry("15", "15"),
                          MapEntry("16", "16"),
                          MapEntry("17", "17"),
                          MapEntry("18", "18"),
                          MapEntry("19", "19"),
                          MapEntry("20", "20"),
                        ],
                        onChangeinside: (d, v) {
                          P1INPUTRAWDATAMAINVAR.NUMBER = d;
                          P1INPUTRAWDATAMAINVAR.tabledata = [];
                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdataall",
                            data: {
                              "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                              "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                              "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              // P1INPUTRAWDATAMAINVAR.NUMBER =
                              //     databuff[0]['NUMBER'];
                              // P1INPUTRAWDATAMAINVAR.POINT =
                              //     databuff[0]['POINT'];

                              Dio().post(
                                GLOserverRAW + "RAWDATA/getdata",
                                data: {
                                  "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                                  "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                                  "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                },
                              ).then((v) {
                                var databuff = v.data;

                                if (databuff.length > 0) {
                                  for (var i = 0; i < databuff.length; i++) {
                                    //
                                    P1INPUTRAWDATAMAINVAR.tabledata.add(
                                        TABLECLASSclass(
                                            // NO: (i + 1).toString(),
                                            NO: (databuff.length - i)
                                                .toString(),
                                            DATA: databuff[i]['Data']));
                                  }

                                  P1INPUTRAWDATAMAINVAR.POINT =
                                      (databuff.length).toString();
                                  setState(() {});
                                } else {
                                  P1INPUTRAWDATAMAINVAR.POINT = "0";
                                  P1INPUTRAWDATAMAINVAR.tabledata = [];
                                  setState(() {});
                                }
                              });
                            }
                          });

                          setState(() {});
                        },
                        // value: P1INPUTRAWDATAMAINVAR.NUMBER,
                        value: P1INPUTRAWDATAMAINVAR.NUMBER,
                        height: 40,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 100,
                        color: Colors.green,
                        child: Center(
                          child: Text(
                              "POINT : ${int.parse(P1INPUTRAWDATAMAINVAR.POINT) + 1}"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      // Dio().post(
                      //   GLOserverRAW + "RAWDATA/getdataall",
                      //   data: {
                      //     "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                      //     "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                      //     "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                      //   },
                      // ).then((v) {
                      //   var databuff = v.data;

                      //   if (databuff.length > 0) {
                      //     P1INPUTRAWDATAMAINVAR.NUMBER = databuff[0]['NUMBER'];
                      //     P1INPUTRAWDATAMAINVAR.POINT = databuff[0]['POINT'];
                      //   }
                      // });

                      P1INPUTRAWDATAMAINVAR.DATASET = '';
                      Dio().post(
                        "http://172.23.10.40:1900/" + "getdata",
                        data: {
                          "INS": P1INPUTRAWDATAMAINVAR.INSTRUMENT,
                          "NO": P1INPUTRAWDATAMAINVAR.POINT,
                          "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                          "LOCATION": P1INPUTRAWDATAMAINVAR.LOCATION,
                          "PLANT": P1INPUTRAWDATAMAINVAR.PLANT,
                        },
                      ).then((v) {
                        var databuff = v.data;
                        // print(databuff);
                        if (databuff['DATA'] != null) {
                          P1INPUTRAWDATAMAINVAR.DATASET =
                              databuff['DATA'].toString();
                          setState(() {});

                          P1INPUTRAWDATAMAINVAR.tabledata = [];
                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdata",
                            data: {
                              "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                              "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                              "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              for (var i = 0; i < databuff.length; i++) {
                                //
                                P1INPUTRAWDATAMAINVAR.tabledata
                                    .add(TABLECLASSclass(
                                        // NO: (i + 1).toString(),
                                        NO: (databuff.length - i).toString(),
                                        DATA: databuff[i]['Data']));
                              }

                              P1INPUTRAWDATAMAINVAR.POINT =
                                  (databuff.length).toString();
                              setState(() {});
                            } else {
                              P1INPUTRAWDATAMAINVAR.tabledata = [];
                              setState(() {});
                            }
                          });
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 150,
                        color: Colors.blue,
                        child: Center(
                          child: Text("GET DATA"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      //
                      if (P1INPUTRAWDATAMAINVAR.POINT == '0') {
                        print("con not back");
                        // if (int.parse(
                        //         ConverstStr(P1INPUTRAWDATAMAINVAR.NUMBER)) !=
                        //     0) {
                        //   P1INPUTRAWDATAMAINVAR.NUMBER = (int.parse(ConverstStr(
                        //               P1INPUTRAWDATAMAINVAR.NUMBER)) -
                        //           1)
                        //       .toString();
                        //   P1INPUTRAWDATAMAINVAR.DATASET = '';
                        //   Dio().post(
                        //     GLOserverRAW + "RAWDATA/DELETELASTrawreport",
                        //     data: {
                        //       "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                        //       "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                        //       "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                        //     },
                        //   ).then((v) {
                        //     var databuff = v.data;

                        //     P1INPUTRAWDATAMAINVAR.tabledata = [];
                        //     Dio().post(
                        //       GLOserverRAW + "RAWDATA/getdata",
                        //       data: {
                        //         "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                        //         "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                        //         "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                        //       },
                        //     ).then((v) {
                        //       var databuff = v.data;

                        //       if (databuff.length > 0) {
                        //         for (var i = 0; i < databuff.length; i++) {
                        //           //
                        //           P1INPUTRAWDATAMAINVAR.tabledata
                        //               .add(TABLECLASSclass(
                        //                   // NO: (i + 1).toString(),
                        //                   NO: (databuff.length - i).toString(),
                        //                   DATA: databuff[i]['Data']));
                        //         }
                        //         setState(() {});
                        //         P1INPUTRAWDATAMAINVAR.POINT =
                        //             (databuff.length).toString();
                        //       } else {
                        //         P1INPUTRAWDATAMAINVAR.tabledata = [];
                        //         P1INPUTRAWDATAMAINVAR.POINT = '0';
                        //         setState(() {});
                        //       }
                        //     });
                        //   });
                        // }
                      } else {
                        P1INPUTRAWDATAMAINVAR.DATASET = '';
                        Dio().post(
                          GLOserverRAW + "RAWDATA/DELETELASTrawreport",
                          data: {
                            "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                            "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                            "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                          },
                        ).then((v) {
                          var databuff = v.data;

                          P1INPUTRAWDATAMAINVAR.tabledata = [];
                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdata",
                            data: {
                              "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                              "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                              "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                              "PLANT": P1INPUTRAWDATAMAINVAR.PLANT,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              for (var i = 0; i < databuff.length; i++) {
                                //
                                P1INPUTRAWDATAMAINVAR.tabledata
                                    .add(TABLECLASSclass(
                                        // NO: (i + 1).toString(),
                                        NO: (databuff.length - i).toString(),
                                        DATA: databuff[i]['Data']));
                              }
                              setState(() {});
                              P1INPUTRAWDATAMAINVAR.POINT =
                                  (databuff.length).toString();
                            } else {
                              P1INPUTRAWDATAMAINVAR.tabledata = [];
                              P1INPUTRAWDATAMAINVAR.POINT = '0';
                              setState(() {});
                            }
                          });
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 60,
                        width: 150,
                        color: Colors.red,
                        child: Center(
                          child: Text("CLEAR DATA"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            // color: Colors.red,
            height: 400,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 80,
                          width: 200,
                          child: AdvanceDropDown(
                            sLabel: "ITEMs",
                            imgpath: '',
                            listdropdown: P1INPUTRAWDATAMAINVAR.ITEMslist,
                            onChangeinside: (d, v) {
                              setState(() {
                                P1INPUTRAWDATAMAINVAR.ITEMs = d;
                              });
                            },
                            value: P1INPUTRAWDATAMAINVAR.ITEMs,
                            height: 40,
                            width: 200,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text("PO:"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text("CUST_NAME:"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text("TP LOT:"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Row(
                                    children: [
                                      Text("PART:"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text(_data.PO),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text(_data.CUST_FULLNM),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text(_data.FG_CHARG),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          _data.PARTNA,
                                          overflow: TextOverflow.clip,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {
                              //
                              P1INPUTRAWDATAMAINVAR.iscontrol = true;
                              P1INPUTRAWDATAMAINVAR.NUMBER = '1';
                              P1INPUTRAWDATAMAINVAR.POINT = '0';
                              P1INPUTRAWDATAMAINVAR.ORDER = '';
                              P1INPUTRAWDATAMAINVAR.ITEMs = '';
                              P1INPUTRAWDATAMAINVAR.ITEMslist = [
                                MapEntry("", "")
                              ];
                              setState(() {});
                              P1INPUTRAWDATAMAINcontext.read<GETITEMS_Bloc>()
                                  .add(GETITEMS_flush());
                              context
                                  .read<P1INPUTRAWDATA_Bloc>()
                                  .add(P1INPUTRAWDATA_SET());
                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              color: Colors.blue,
                              child: Center(
                                child: Text("CLEAR PO"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          InkWell(
                            onTap: () {
                              //
                              P1INPUTRAWDATAMAINVAR.iscontrol = true;
                              P1INPUTRAWDATAMAINVAR.LOCATION = '';
                              P1INPUTRAWDATAMAINVAR.PLANT = '';
                              P1INPUTRAWDATAMAINVAR.INSTRUMENT = '';
                              P1INPUTRAWDATAMAINVAR.ORDER = '';
                              P1INPUTRAWDATAMAINVAR.ITEMs = '';
                              P1INPUTRAWDATAMAINVAR.SPCdata = '';
                              P1INPUTRAWDATAMAINVAR.SPC = '';

                              P1INPUTRAWDATAMAINVAR.NUMBER = '1';
                              P1INPUTRAWDATAMAINVAR.POINT = '0';

                              P1INPUTRAWDATAMAINVAR.INSTRUMENTlist = [
                                MapEntry("", "")
                              ];
                              P1INPUTRAWDATAMAINVAR.Plantlist = [
                                MapEntry("", "")
                              ];
                              P1INPUTRAWDATAMAINVAR.tabledata = [];
                              //
                              P1INPUTRAWDATAMAINVAR.ITEMs = '';
                              P1INPUTRAWDATAMAINVAR.ITEMslist = [
                                MapEntry("", "")
                              ];
                              P1INPUTRAWDATAMAINcontext.read<GETITEMS_Bloc>()
                                  .add(GETITEMS_flush());
                              //
                              setState(() {});

                              context
                                  .read<P1INPUTRAWDATA_Bloc>()
                                  .add(P1INPUTRAWDATA_SET());

                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              color: Colors.blue,
                              child: Center(
                                child: Text("END"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 550,
                  height: 400,
                  // color: Colors.amber,
                  child: Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              AdvanceDropDown(
                                // isEnable: P1INPUTRAWDATAMAINVAR.PLANT != '',
                                // sLabel: "Select Loacation",
                                imgpath: '',
                                listdropdown: const [
                                  MapEntry("", ""),
                                  MapEntry("DATA", "DATA"),
                                  MapEntry("PICTURE", "PICTURE"),
                                ],
                                onChangeinside: (d, v) {
                                  P1INPUTRAWDATAMAINVAR.DATATYPE = d;

                                  setState(() {});
                                },
                                value: P1INPUTRAWDATAMAINVAR.DATATYPE,
                                height: 40,
                                width: 150,
                              ),
                              InkWell(
                                onTap: () {
                                  // if (P1INPUTRAWDATAMAINVAR.ITEMs != '') {
                                  //
                                  //RAWDATA/insertdata
                                  if (P1INPUTRAWDATAMAINVAR.DATATYPE ==
                                      'PICTURE') {
                                    Dio().post(
                                      GLOserverRAW + "RAWDATA/insertdata",
                                      data: {
                                        "Location":
                                            P1INPUTRAWDATAMAINVAR.LOCATION,
                                        "Plant": P1INPUTRAWDATAMAINVAR.PLANT,
                                        "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                                        "CP": _data.CPMAT,
                                        "FG": _data.FGMAT,
                                        "ItemsCode": "",
                                        "ItemsName": "",
                                        "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                                        "POINT": P1INPUTRAWDATAMAINVAR.POINT,
                                        "Data": "",
                                        "Picture": P1INPUTRAWDATAMAINVAR.Pimg,
                                        "UserInput": USERDATA.ID,
                                        "TYPE": P1INPUTRAWDATAMAINVAR.SPC,

                                        "INSTRUMENT": "",
                                        "SP02": P1INPUTRAWDATAMAINVAR.ITEMs,

                                        //
                                        "SEQ": _data.SEQ,
                                        "QTYT": _data.QTYT,
                                        "UNIT": _data.UNIT,
                                        "CUSTNA": _data.CUSTNA,
                                        "PARTNA": _data.PARTNA,
                                        "PARTNO": _data.PARTNO,
                                        "PROC": _data.PROC,
                                        "CUSLOTNO": _data.CUSLOTNO,
                                        "FG_CHARG": _data.FG_CHARG,
                                        "CUST_FULLNM": _data.CUST_FULLNM,
                                      },
                                    ).then((v) {
                                      //
                                      // var databuff = v.data;
                                      // context
                                      //     .read<SIGNATURESGET_Bloc>()
                                      //     .add(SIGNATURESGET_MATCP());
                                      P1INPUTRAWDATAMAINVAR.tabledata = [];
                                      Dio().post(
                                        GLOserverRAW + "RAWDATA/getdata",
                                        data: {
                                          "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                                          "NUMBER":
                                              P1INPUTRAWDATAMAINVAR.NUMBER,
                                          "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                        },
                                      ).then((v) {
                                        var databuff = v.data;
                                        // print(databuff);
                                        if (databuff.length > 0) {
                                          // print(databuff);
                                          setState(() {});
                                          for (var i = 0;
                                              i < databuff.length;
                                              i++) {
                                            //
                                            P1INPUTRAWDATAMAINVAR.tabledata.add(
                                                TABLECLASSclass(
                                                    // NO: (i + 1).toString(),
                                                    NO: (databuff.length - i)
                                                        .toString(),
                                                    DATA: databuff[i]['Data']));
                                          }

                                          P1INPUTRAWDATAMAINVAR.POINT =
                                              (databuff.length).toString();
                                          P1INPUTRAWDATAMAINVAR.Pimg = '';
                                        } else {
                                          P1INPUTRAWDATAMAINVAR.tabledata = [];
                                          setState(() {});
                                        }
                                      });

                                      setState(() {});
                                    });
                                  } else {
                                    Dio().post(
                                      GLOserverRAW + "RAWDATA/insertdata",
                                      data: {
                                        "Location":
                                            P1INPUTRAWDATAMAINVAR.LOCATION,
                                        "Plant": P1INPUTRAWDATAMAINVAR.PLANT,
                                        "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                                        "CP": _data.CPMAT,
                                        "FG": _data.FGMAT,
                                        "ItemsCode": "",
                                        "ItemsName": "",
                                        "NUMBER": P1INPUTRAWDATAMAINVAR.NUMBER,
                                        "POINT": P1INPUTRAWDATAMAINVAR.POINT,
                                        "Data": P1INPUTRAWDATAMAINVAR.DATASET,
                                        "Picture": "",
                                        "UserInput": USERDATA.ID,
                                        "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                        "SP02": P1INPUTRAWDATAMAINVAR.ITEMs,

                                        "INSTRUMENT":
                                            P1INPUTRAWDATAMAINVAR.INSTRUMENT,

                                        //
                                        "SEQ": _data.SEQ,
                                        "QTYT": _data.QTYT,
                                        "UNIT": _data.UNIT,
                                        "CUSTNA": _data.CUSTNA,
                                        "PARTNA": _data.PARTNA,
                                        "PARTNO": _data.PARTNO,
                                        "PROC": _data.PROC,
                                        "CUSLOTNO": _data.CUSLOTNO,
                                        "FG_CHARG": _data.FG_CHARG,
                                        "CUST_FULLNM": _data.CUST_FULLNM,
                                      },
                                    ).then((v) {
                                      //

                                      //-----------------------------------------------------------------
                                      P1INPUTRAWDATAMAINVAR.DATASET = '';
                                      Dio().post(
                                        "http://172.23.10.40:1900/" + "getdata",
                                        data: {
                                          "INS":
                                              P1INPUTRAWDATAMAINVAR.INSTRUMENT,
                                          "NO": P1INPUTRAWDATAMAINVAR.POINT,
                                          "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                          "LOCATION":
                                              P1INPUTRAWDATAMAINVAR.LOCATION,
                                          "PLANT": P1INPUTRAWDATAMAINVAR.PLANT,
                                        },
                                      ).then((v) {
                                        var databuff = v.data;
                                        print(databuff);
                                        if (databuff['DATA'] != null) {
                                          P1INPUTRAWDATAMAINVAR.DATASET =
                                              databuff['DATA'].toString();
                                          setState(() {});
                                        }
                                      });
                                      P1INPUTRAWDATAMAINVAR.tabledata = [];
                                      Dio().post(
                                        GLOserverRAW + "RAWDATA/getdata",
                                        data: {
                                          "Order": P1INPUTRAWDATAMAINVAR.ORDER,
                                          "NUMBER":
                                              P1INPUTRAWDATAMAINVAR.NUMBER,
                                          "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                        },
                                      ).then((v) {
                                        var databuff = v.data;
                                        P1INPUTRAWDATAMAINVAR.DATASET = '';
                                        if (databuff.length > 0) {
                                          for (var i = 0;
                                              i < databuff.length;
                                              i++) {
                                            //
                                            P1INPUTRAWDATAMAINVAR.tabledata.add(
                                                TABLECLASSclass(
                                                    // NO: (i + 1).toString(),
                                                    NO: (databuff.length - i)
                                                        .toString(),
                                                    DATA: databuff[i]['Data']));
                                          }

                                          P1INPUTRAWDATAMAINVAR.POINT =
                                              (databuff.length).toString();
                                        } else {
                                          P1INPUTRAWDATAMAINVAR.tabledata = [];
                                          setState(() {});
                                        }
                                        setState(() {});
                                      });

                                      setState(() {});
                                    });
                                  }
                                  // } else {
                                  //   showErrorPopup(
                                  //       context, "Please select items");
                                  // }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text("NEXT >"),
                                    ),
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () {
                                  if (P1INPUTRAWDATAMAINVAR.AUTOGET == 'auto') {
                                    P1INPUTRAWDATAMAINVAR.AUTOGET = '';
                                    P1INPUTRAWDATAMAINVAR.DHtimer.cancel();
                                    setState(() {});
                                  } else {
                                    P1INPUTRAWDATAMAINVAR.AUTOGET = 'auto';

                                    // Timer timer =
                                    //     Timer(const Duration(seconds: 1), () {
                                    //   //
                                    //   Dio().post(
                                    //     "http://172.23.10.40:1900/" + "getdata",
                                    //     data: {
                                    //       "INS":
                                    //           P1INPUTRAWDATAMAINVAR.INSTRUMENT,
                                    //       "NO": P1INPUTRAWDATAMAINVAR.POINT,
                                    //       "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                    //       "LOCATION":
                                    //           P1INPUTRAWDATAMAINVAR.LOCATION,
                                    //       "PLANT": P1INPUTRAWDATAMAINVAR.PLANT,
                                    //     },
                                    //   ).then((v) {
                                    //     var databuff = v.data;
                                    //     // print(databuff);
                                    //     if (databuff['DATA'] != null) {
                                    //       P1INPUTRAWDATAMAINVAR.DATASET =
                                    //           databuff['DATA'].toString();
                                    //       setState(() {});

                                    //       P1INPUTRAWDATAMAINVAR.tabledata = [];
                                    //       Dio().post(
                                    //         GLOserverRAW + "RAWDATA/getdata",
                                    //         data: {
                                    //           "Order":
                                    //               P1INPUTRAWDATAMAINVAR.ORDER,
                                    //           "NUMBER":
                                    //               P1INPUTRAWDATAMAINVAR.NUMBER,
                                    //           "TYPE": P1INPUTRAWDATAMAINVAR.SPC,
                                    //         },
                                    //       ).then((v) {
                                    //         var databuff = v.data;

                                    //         if (databuff.length > 0) {
                                    //           for (var i = 0;
                                    //               i < databuff.length;
                                    //               i++) {
                                    //             //
                                    //             P1INPUTRAWDATAMAINVAR.tabledata
                                    //                 .add(TABLECLASSclass(
                                    //                     // NO: (i + 1).toString(),
                                    //                     NO: (databuff.length -
                                    //                             i)
                                    //                         .toString(),
                                    //                     DATA: databuff[i]
                                    //                         ['Data']));
                                    //           }

                                    //           P1INPUTRAWDATAMAINVAR.POINT =
                                    //               (databuff.length).toString();
                                    //           setState(() {});
                                    //         } else {
                                    //           P1INPUTRAWDATAMAINVAR.tabledata =
                                    //               [];
                                    //           setState(() {});
                                    //         }
                                    //       });
                                    //     }
                                    //   });
                                    // });
                                    // P1INPUTRAWDATAMAINVAR.DHtimer = timer;

                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    color:
                                        P1INPUTRAWDATAMAINVAR.AUTOGET == 'auto'
                                            ? Colors.green
                                            : Colors.grey,
                                    child: Center(
                                      child: Text("AUTO GET"),
                                    ),
                                  ),
                                ),
                              )

                              // InkWell(
                              //   onTap: () {
                              //     P1INPUTRAWDATAMAINVAR.NUMBER =
                              //         (int.parse(P1INPUTRAWDATAMAINVAR.NUMBER) +
                              //                 1)
                              //             .toString();
                              //     P1INPUTRAWDATAMAINVAR.POINT = '0';
                              //     P1INPUTRAWDATAMAINVAR.tabledata = [];
                              //     setState(() {});
                              //   },
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(left: 20),
                              //     child: Container(
                              //       height: 40,
                              //       width: 150,
                              //       color: Colors.blue,
                              //       child: Center(
                              //         child: Text("FINISH"),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              height: 304,
                              width: 504,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    // SizedBox(
                                    //   height: 40,
                                    // )
                                    if (P1INPUTRAWDATAMAINVAR.DATATYPE == '' ||
                                        P1INPUTRAWDATAMAINVAR.DATATYPE ==
                                            'DATA') ...[
                                      SizedBox(
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 300,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 2),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  P1INPUTRAWDATAMAINVAR.DATASET,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 300,
                                              width: 250,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.black,
                                                  width: 2,
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: rowbox_type0(
                                                            Head: "NO",
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: rowbox_type0(
                                                            Head: "DATA",
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    for (int i = 0;
                                                        i <
                                                            P1INPUTRAWDATAMAINVAR
                                                                .tabledata
                                                                .length;
                                                        i++) ...[
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: rowbox_type0(
                                                              Head:
                                                                  P1INPUTRAWDATAMAINVAR
                                                                      .tabledata[
                                                                          i]
                                                                      .NO,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: rowbox_type0(
                                                              Head:
                                                                  P1INPUTRAWDATAMAINVAR
                                                                      .tabledata[
                                                                          i]
                                                                      .DATA,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ]
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ] else ...[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 400,
                                          child: InkWell(
                                            onTap: () async {
                                              var picked = await FilePicker
                                                  .platform
                                                  .pickFiles();
                                              Uint8List? imageByte;
                                              Uint8List? resizedData;

                                              if (picked != null) {
                                                imageByte =
                                                    picked.files.first.bytes;
                                                IMG.Image? img =
                                                    IMG.decodeImage(imageByte!);
                                                // IMG.Image? img2 = IMG.copyResize(img!, width: 500);
                                                resizedData =
                                                    IMG.encodeJpg(img!)
                                                        as Uint8List?;
                                                //      "data:image/jpeg;base64," +
                                                P1INPUTRAWDATAMAINVAR.Pimg =
                                                    base64.encode(resizedData!);

                                                //----------------------------------------------------------
                                                // Dio().post(
                                                //   serverGB + "SIGNATURE_UPLOAD",
                                                //   data: {
                                                //     "ID": USERDATA.ID,
                                                //     "SIGNATURE":
                                                //         P1INPUTRAWDATAMAINVAR
                                                //             .Pimg,
                                                //   },
                                                // ).then((v) {
                                                //   //
                                                //   // var databuff = v.data;
                                                //   // context
                                                //   //     .read<SIGNATURESGET_Bloc>()
                                                //   //     .add(SIGNATURESGET_MATCP());

                                                setState(() {});
                                                // });
                                                //----------------------------------------------------------
                                              }
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 100,
                                              color: Colors.green,
                                              child: Center(
                                                child: Text("UPLOAD"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          // if ((widget.Mdata?.Pimg ?? '') != '') ...[

                                          if ((P1INPUTRAWDATAMAINVAR.Pimg) !=
                                              '') ...[
                                            PicShowW(
                                              base64:
                                                  P1INPUTRAWDATAMAINVAR.Pimg,
                                              height: 200,
                                              width: 400,
                                            )
                                          ] else ...[
                                            Container(
                                              height: 200,
                                              width: 400,
                                              color: Colors.grey.shade400,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                // children: const [
                                                //   SizedBox(width: 30),
                                                //   CircularProgressIndicator(),
                                                //   SizedBox(width: 20),
                                                //   Text("Loading"),
                                                // ],
                                              ),
                                            )
                                          ],
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
