import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as IMG;

import '../../bloc/BlocEvent/02-01-P2INPUTRAWDATA2.dart';
import '../../bloc/BlocEvent/02-03-GETITEMS2.dart';
import '../../data/global.dart';
import '../../model/model.dart';
import '../../widget/common/Advancedropdown.dart';
import '../../widget/common/ComInputText.dart';
import '../../widget/common/ErrorPopup.dart';
import '../../widget/common/IMGviewWID.dart';
import '../../widget/common/Loading.dart';
import '../../widget/common/Safty.dart';
import '../../widget/newtable/tablebox.dart';
import 'P2INPUTRAWDATA2VAR.dart';

late BuildContext P2INPUTRAWDATA2MAINcontext;

class P2INPUTRAWDATA2MAIN extends StatefulWidget {
  P2INPUTRAWDATA2MAIN({
    super.key,
    this.data,
    this.dataDD,
    this.dataDD2,
  });
  P2INPUTRAWDATA2class? data;
  List<MapEntry<String, String>>? dataDD;
  List<MapEntry<String, String>>? dataDD2;
  @override
  State<P2INPUTRAWDATA2MAIN> createState() => _P2INPUTRAWDATA2MAINState();
}

class _P2INPUTRAWDATA2MAINState extends State<P2INPUTRAWDATA2MAIN> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    P2INPUTRAWDATA2MAINVAR.NUMBER = '1';
    P2INPUTRAWDATA2MAINVAR.POINT = '0';
    P2INPUTRAWDATA2MAINVAR.tabledata = [];
    P2INPUTRAWDATA2MAINVAR.AUTOGET == '';
  }

  @override
  void dispose() {
    super.dispose();

    P2INPUTRAWDATA2MAINVAR.DHtimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    P2INPUTRAWDATA2MAINcontext = context;
    P2INPUTRAWDATA2class _data = widget.data ?? P2INPUTRAWDATA2class();
    List<MapEntry<String, String>> _dataDD = widget.dataDD ?? [];
    List<MapEntry<String, String>> _dataDD2 = widget.dataDD2 ?? [];
    // if (_dataDD.isNotEmpty) {
    //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist = _dataDD;
    // }
    if (_dataDD2.isNotEmpty) {
      P2INPUTRAWDATA2MAINVAR.ITEMslist = _dataDD2;
    }

    if (P2INPUTRAWDATA2MAINVAR.AUTOGET == 'auto') {
      P2INPUTRAWDATA2MAINVAR.DHtimer = Timer(const Duration(seconds: 1), () {
        //
        Dio().post(
          "http://172.23.10.40:1900/" + "getdata",
          data: {
            "INS": P2INPUTRAWDATA2MAINVAR.INSTRUMENT,
            "NO": P2INPUTRAWDATA2MAINVAR.POINT,
            "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
            "LOCATION": P2INPUTRAWDATA2MAINVAR.LOCATION,
            "PLANT": P2INPUTRAWDATA2MAINVAR.PLANT,
          },
        ).then((v) {
          var databuff = v.data;
          // print(databuff);
          if (databuff['DATA'] != null) {
            P2INPUTRAWDATA2MAINVAR.DATASET = databuff['DATA'].toString();
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(
              //     height: 80,
              //     width: 200,
              //     child: AdvanceDropDown(
              //       isEnable: P2INPUTRAWDATA2MAINVAR.PLANT != '',
              //       sLabel: "Select Loacation",
              //       imgpath: '',
              //       listdropdown: const [
              //         MapEntry("", ""),
              //         MapEntry("BP12", "BP12"),
              //         MapEntry("GW", "GW"),
              //         MapEntry("HES", "HES"),
              //       ],
              //       onChangeinside: (d, v) {
              //         P2INPUTRAWDATA2MAINVAR.LOCATION = d;

              //         if (P2INPUTRAWDATA2MAINVAR.LOCATION == 'BP12') {
              //           P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
              //           P2INPUTRAWDATA2MAINVAR.Plantlist =
              //               P2INPUTRAWDATA2MAINVAR.plantBP12;
              //         } else if (P2INPUTRAWDATA2MAINVAR.LOCATION == 'GW') {
              //           P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2200';
              //           P2INPUTRAWDATA2MAINVAR.Plantlist =
              //               P2INPUTRAWDATA2MAINVAR.plantGW;
              //         } else if (P2INPUTRAWDATA2MAINVAR.LOCATION == 'HES') {
              //           P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2300';
              //           P2INPUTRAWDATA2MAINVAR.Plantlist =
              //               P2INPUTRAWDATA2MAINVAR.plantHES;
              //         } else {
              //           P2INPUTRAWDATA2MAINVAR.Plantlist =
              //               P2INPUTRAWDATA2MAINVAR.blank;
              //         }
              //         setState(() {});
              //       },
              //       value: P2INPUTRAWDATA2MAINVAR.LOCATION,
              //       height: 40,
              //       width: 200,
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: SizedBox(
              //     height: 80,
              //     width: 200,
              //     child: AdvanceDropDown(
              //       sLabel: "Plant",
              //       imgpath: '',
              //       isEnable: P2INPUTRAWDATA2MAINVAR.PLANT != '',
              //       listdropdown: P2INPUTRAWDATA2MAINVAR.Plantlist,
              //       onChangeinside: (d, v) {
              //         setState(() {
              //           P2INPUTRAWDATA2MAINVAR.PLANT = d;
              //         });

              //         // context
              //         //     .read<GETINSTRUMENT_Bloc>()
              //         //     .add(GETINSTRUMENT_GET());

              //         // if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'BP12GAS') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.BP12GAS;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'BP12PH') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.BP12PH;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'BP12PAL') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.BP12PAL;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'BP12PVD') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.BP12PVD;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'BP12KNG') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.BP12KNG;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'GWGAS') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.GWGAS;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'HESGAS') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.HESGAS;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'HESPH') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.HESPH;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'HESDEL') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.HESDEL;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'HESPAL') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.HESPAL;
              //         // } else if ((P2INPUTRAWDATA2MAINVAR.LOCATION +
              //         //         P2INPUTRAWDATA2MAINVAR.PLANT) ==
              //         //     'HESISN') {
              //         //   P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist =
              //         //       P2INPUTRAWDATA2MAINVAR.HESISN;
              //         // }
              //         setState(() {});
              //       },
              //       value: P2INPUTRAWDATA2MAINVAR.PLANT,
              //       height: 40,
              //       width: 200,
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                  width: 200,
                  // child: Center(child: Text(data),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: 200,
                  child: AdvanceDropDown(
                    isEnable: P2INPUTRAWDATA2MAINVAR.SPCdata != '',
                    sLabel: "INSPCETION TYPE",
                    imgpath: '',
                    listdropdown: P2INPUTRAWDATA2MAINVAR.SPClist,
                    onChangeinside: (d, v) {
                      setState(() {
                        P2INPUTRAWDATA2MAINVAR.SPCdata = d;
                        P2INPUTRAWDATA2MAINVAR.SPC = v;
                      });
                    },
                    value: P2INPUTRAWDATA2MAINVAR.SPCdata,
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
                    listdropdown: P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist,
                    onChangeinside: (d, v) {
                      setState(() {
                        P2INPUTRAWDATA2MAINVAR.INSTRUMENT = d;
                      });
                    },
                    value: P2INPUTRAWDATA2MAINVAR.INSTRUMENT,
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
                        isContr: P2INPUTRAWDATA2MAINVAR.iscontrol,
                        fnContr: (input) {
                          setState(() {
                            P2INPUTRAWDATA2MAINVAR.iscontrol = input;
                          });
                        },
                        sValue: P2INPUTRAWDATA2MAINVAR.ORDER,
                        returnfunc: (String s) {
                          // if (s.length >= 12) {
                          //   P2INPUTRAWDATA2MAINVAR.ORDER = s.substring(2, 12);
                          //   setState(() {});
                          // } else {
                          //   P2INPUTRAWDATA2MAINVAR.ORDER = s;
                          //   setState(() {});
                          // }
                          P2INPUTRAWDATA2MAINVAR.ORDER = s;

                          print(P2INPUTRAWDATA2MAINVAR.ORDER);
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
                        P2INPUTRAWDATA2MAINVAR.tabledata = [];
                        if (P2INPUTRAWDATA2MAINVAR.LOCATION != '' &&
                            P2INPUTRAWDATA2MAINVAR.PLANT != '' &&
                            P2INPUTRAWDATA2MAINVAR.SPCdata != '' &&
                            P2INPUTRAWDATA2MAINVAR.SPC != '') {
                          context
                              .read<P2INPUTRAWDATA2_Bloc>()
                              .add(P2INPUTRAWDATA2_GET());

                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdataall",
                            data: {
                              "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                              "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                              "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              P2INPUTRAWDATA2MAINVAR.NUMBER =
                                  databuff[0]['NUMBER'];
                              P2INPUTRAWDATA2MAINVAR.POINT =
                                  databuff[0]['POINT'];
                              Dio().post(
                                GLOserverRAW + "RAWDATA/getdata",
                                data: {
                                  "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                                  "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                                  "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                },
                              ).then((v) {
                                var databuff = v.data;
                                // print(databuff);
                                if (databuff.length > 0) {
                                  // print(databuff);
                                  setState(() {});
                                  for (var i = 0; i < databuff.length; i++) {
                                    //
                                    P2INPUTRAWDATA2MAINVAR.tabledata.add(
                                        TABLECLASSclass(
                                            // NO: (i + 1).toString(),
                                            NO: (databuff.length - i)
                                                .toString(),
                                            DATA: databuff[i]['Data']));
                                  }

                                  P2INPUTRAWDATA2MAINVAR.POINT =
                                      (databuff.length).toString();
                                } else {
                                  P2INPUTRAWDATA2MAINVAR.tabledata = [];
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
                      color: P2INPUTRAWDATA2MAINVAR.LOCATION != '' &&
                              P2INPUTRAWDATA2MAINVAR.PLANT != '' &&
                              P2INPUTRAWDATA2MAINVAR.SPCdata != '' &&
                              P2INPUTRAWDATA2MAINVAR.SPC != '' &&
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
                          //         "NUMBER : ${int.parse(P2INPUTRAWDATA2MAINVAR.NUMBER) + 1}"),
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
                          P2INPUTRAWDATA2MAINVAR.NUMBER = d;
                          P2INPUTRAWDATA2MAINVAR.tabledata = [];
                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdataall",
                            data: {
                              "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                              "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                              "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              // P2INPUTRAWDATA2MAINVAR.NUMBER =
                              //     databuff[0]['NUMBER'];
                              // P2INPUTRAWDATA2MAINVAR.POINT =
                              //     databuff[0]['POINT'];

                              Dio().post(
                                GLOserverRAW + "RAWDATA/getdata",
                                data: {
                                  "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                                  "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                                  "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                },
                              ).then((v) {
                                var databuff = v.data;

                                if (databuff.length > 0) {
                                  for (var i = 0; i < databuff.length; i++) {
                                    //
                                    P2INPUTRAWDATA2MAINVAR.tabledata.add(
                                        TABLECLASSclass(
                                            // NO: (i + 1).toString(),
                                            NO: (databuff.length - i)
                                                .toString(),
                                            DATA: databuff[i]['Data']));
                                  }

                                  P2INPUTRAWDATA2MAINVAR.POINT =
                                      (databuff.length).toString();
                                  setState(() {});
                                } else {
                                  P2INPUTRAWDATA2MAINVAR.POINT = "0";
                                  P2INPUTRAWDATA2MAINVAR.tabledata = [];
                                  setState(() {});
                                }
                              });
                            }
                          });

                          setState(() {});
                        },
                        // value: P2INPUTRAWDATA2MAINVAR.NUMBER,
                        value: P2INPUTRAWDATA2MAINVAR.NUMBER,
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
                              "POINT : ${int.parse(P2INPUTRAWDATA2MAINVAR.POINT) + 1}"),
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
                      //     "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                      //     "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                      //     "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                      //   },
                      // ).then((v) {
                      //   var databuff = v.data;

                      //   if (databuff.length > 0) {
                      //     P2INPUTRAWDATA2MAINVAR.NUMBER = databuff[0]['NUMBER'];
                      //     P2INPUTRAWDATA2MAINVAR.POINT = databuff[0]['POINT'];
                      //   }
                      // });

                      P2INPUTRAWDATA2MAINVAR.DATASET = '';
                      Dio().post(
                        "http://172.23.10.40:1900/" + "getdata",
                        data: {
                          "INS": P2INPUTRAWDATA2MAINVAR.INSTRUMENT,
                          "NO": P2INPUTRAWDATA2MAINVAR.POINT,
                          "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                          "LOCATION": P2INPUTRAWDATA2MAINVAR.LOCATION,
                          "PLANT": P2INPUTRAWDATA2MAINVAR.PLANT,
                        },
                      ).then((v) {
                        var databuff = v.data;
                        // print(databuff);
                        if (databuff['DATA'] != null) {
                          P2INPUTRAWDATA2MAINVAR.DATASET =
                              databuff['DATA'].toString();
                          setState(() {});

                          P2INPUTRAWDATA2MAINVAR.tabledata = [];
                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdata",
                            data: {
                              "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                              "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                              "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              for (var i = 0; i < databuff.length; i++) {
                                //
                                P2INPUTRAWDATA2MAINVAR.tabledata
                                    .add(TABLECLASSclass(
                                        // NO: (i + 1).toString(),
                                        NO: (databuff.length - i).toString(),
                                        DATA: databuff[i]['Data']));
                              }

                              P2INPUTRAWDATA2MAINVAR.POINT =
                                  (databuff.length).toString();
                              setState(() {});
                            } else {
                              P2INPUTRAWDATA2MAINVAR.tabledata = [];
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
                      if (P2INPUTRAWDATA2MAINVAR.POINT == '0') {
                        print("con not back");
                        // if (int.parse(
                        //         ConverstStr(P2INPUTRAWDATA2MAINVAR.NUMBER)) !=
                        //     0) {
                        //   P2INPUTRAWDATA2MAINVAR.NUMBER = (int.parse(ConverstStr(
                        //               P2INPUTRAWDATA2MAINVAR.NUMBER)) -
                        //           1)
                        //       .toString();
                        //   P2INPUTRAWDATA2MAINVAR.DATASET = '';
                        //   Dio().post(
                        //     GLOserverRAW + "RAWDATA/DELETELASTrawreport",
                        //     data: {
                        //       "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                        //       "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                        //       "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                        //     },
                        //   ).then((v) {
                        //     var databuff = v.data;

                        //     P2INPUTRAWDATA2MAINVAR.tabledata = [];
                        //     Dio().post(
                        //       GLOserverRAW + "RAWDATA/getdata",
                        //       data: {
                        //         "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                        //         "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                        //         "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                        //       },
                        //     ).then((v) {
                        //       var databuff = v.data;

                        //       if (databuff.length > 0) {
                        //         for (var i = 0; i < databuff.length; i++) {
                        //           //
                        //           P2INPUTRAWDATA2MAINVAR.tabledata
                        //               .add(TABLECLASSclass(
                        //                   // NO: (i + 1).toString(),
                        //                   NO: (databuff.length - i).toString(),
                        //                   DATA: databuff[i]['Data']));
                        //         }
                        //         setState(() {});
                        //         P2INPUTRAWDATA2MAINVAR.POINT =
                        //             (databuff.length).toString();
                        //       } else {
                        //         P2INPUTRAWDATA2MAINVAR.tabledata = [];
                        //         P2INPUTRAWDATA2MAINVAR.POINT = '0';
                        //         setState(() {});
                        //       }
                        //     });
                        //   });
                        // }
                      } else {
                        P2INPUTRAWDATA2MAINVAR.DATASET = '';
                        Dio().post(
                          GLOserverRAW + "RAWDATA/DELETELASTrawreport",
                          data: {
                            "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                            "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                            "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                          },
                        ).then((v) {
                          var databuff = v.data;

                          P2INPUTRAWDATA2MAINVAR.tabledata = [];
                          Dio().post(
                            GLOserverRAW + "RAWDATA/getdata",
                            data: {
                              "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                              "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                              "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                              "PLANT": P2INPUTRAWDATA2MAINVAR.PLANT,
                            },
                          ).then((v) {
                            var databuff = v.data;

                            if (databuff.length > 0) {
                              for (var i = 0; i < databuff.length; i++) {
                                //
                                P2INPUTRAWDATA2MAINVAR.tabledata
                                    .add(TABLECLASSclass(
                                        // NO: (i + 1).toString(),
                                        NO: (databuff.length - i).toString(),
                                        DATA: databuff[i]['Data']));
                              }
                              setState(() {});
                              P2INPUTRAWDATA2MAINVAR.POINT =
                                  (databuff.length).toString();
                            } else {
                              P2INPUTRAWDATA2MAINVAR.tabledata = [];
                              P2INPUTRAWDATA2MAINVAR.POINT = '0';
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
                            listdropdown: P2INPUTRAWDATA2MAINVAR.ITEMslist,
                            onChangeinside: (d, v) {
                              setState(() {
                                P2INPUTRAWDATA2MAINVAR.ITEMs = d;
                              });
                            },
                            value: P2INPUTRAWDATA2MAINVAR.ITEMs,
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
                              P2INPUTRAWDATA2MAINVAR.iscontrol = true;
                              P2INPUTRAWDATA2MAINVAR.NUMBER = '1';
                              P2INPUTRAWDATA2MAINVAR.POINT = '0';
                              P2INPUTRAWDATA2MAINVAR.ORDER = '';
                              P2INPUTRAWDATA2MAINVAR.ITEMs = '';
                              P2INPUTRAWDATA2MAINVAR.ITEMslist = [
                                MapEntry("", "")
                              ];
                              setState(() {});
                              P2INPUTRAWDATA2MAINcontext.read<GETITEMS_Bloc>()
                                  .add(GETITEMS_flush());
                              context
                                  .read<P2INPUTRAWDATA2_Bloc>()
                                  .add(P2INPUTRAWDATA2_SET());
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
                              P2INPUTRAWDATA2MAINVAR.iscontrol = true;
                              P2INPUTRAWDATA2MAINVAR.LOCATION = '';
                              P2INPUTRAWDATA2MAINVAR.PLANT = '';
                              P2INPUTRAWDATA2MAINVAR.INSTRUMENT = '';
                              P2INPUTRAWDATA2MAINVAR.ORDER = '';
                              P2INPUTRAWDATA2MAINVAR.ITEMs = '';
                              P2INPUTRAWDATA2MAINVAR.SPCdata = '';
                              P2INPUTRAWDATA2MAINVAR.SPC = '';

                              P2INPUTRAWDATA2MAINVAR.NUMBER = '1';
                              P2INPUTRAWDATA2MAINVAR.POINT = '0';

                              P2INPUTRAWDATA2MAINVAR.INSTRUMENTlist = [
                                MapEntry("", "")
                              ];
                              P2INPUTRAWDATA2MAINVAR.Plantlist = [
                                MapEntry("", "")
                              ];
                              P2INPUTRAWDATA2MAINVAR.tabledata = [];
                              //
                              P2INPUTRAWDATA2MAINVAR.ITEMs = '';
                              P2INPUTRAWDATA2MAINVAR.ITEMslist = [
                                MapEntry("", "")
                              ];
                              P2INPUTRAWDATA2MAINcontext.read<GETITEMS_Bloc>()
                                  .add(GETITEMS_flush());
                              //
                              setState(() {});

                              context
                                  .read<P2INPUTRAWDATA2_Bloc>()
                                  .add(P2INPUTRAWDATA2_SET());

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
                                // isEnable: P2INPUTRAWDATA2MAINVAR.PLANT != '',
                                // sLabel: "Select Loacation",
                                imgpath: '',
                                listdropdown: const [
                                  MapEntry("", ""),
                                  MapEntry("DATA", "DATA"),
                                  MapEntry("PICTURE", "PICTURE"),
                                ],
                                onChangeinside: (d, v) {
                                  P2INPUTRAWDATA2MAINVAR.DATATYPE = d;

                                  setState(() {});
                                },
                                value: P2INPUTRAWDATA2MAINVAR.DATATYPE,
                                height: 40,
                                width: 150,
                              ),
                              InkWell(
                                onTap: () {
                                  // if (P2INPUTRAWDATA2MAINVAR.ITEMs != '') {
                                  //
                                  //RAWDATA/insertdata
                                  if (P2INPUTRAWDATA2MAINVAR.DATATYPE ==
                                      'PICTURE') {
                                    Dio().post(
                                      GLOserverRAW + "RAWDATA/insertdata",
                                      data: {
                                        "Location":
                                            P2INPUTRAWDATA2MAINVAR.LOCATION,
                                        "Plant": P2INPUTRAWDATA2MAINVAR.PLANT,
                                        "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                                        "CP": _data.CPMAT,
                                        "FG": _data.FGMAT,
                                        "ItemsCode": "",
                                        "ItemsName": "",
                                        "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                                        "POINT": P2INPUTRAWDATA2MAINVAR.POINT,
                                        "Data": "",
                                        "Picture": P2INPUTRAWDATA2MAINVAR.Pimg,
                                        "UserInput": USERDATA.ID,
                                        "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,

                                        "INSTRUMENT": "",
                                        "SP02": P2INPUTRAWDATA2MAINVAR.ITEMs,

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
                                      P2INPUTRAWDATA2MAINVAR.tabledata = [];
                                      Dio().post(
                                        GLOserverRAW + "RAWDATA/getdata",
                                        data: {
                                          "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                                          "NUMBER":
                                              P2INPUTRAWDATA2MAINVAR.NUMBER,
                                          "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
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
                                            P2INPUTRAWDATA2MAINVAR.tabledata
                                                .add(TABLECLASSclass(
                                                    // NO: (i + 1).toString(),
                                                    NO: (databuff.length - i)
                                                        .toString(),
                                                    DATA: databuff[i]['Data']));
                                          }

                                          P2INPUTRAWDATA2MAINVAR.POINT =
                                              (databuff.length).toString();
                                          P2INPUTRAWDATA2MAINVAR.Pimg = '';
                                        } else {
                                          P2INPUTRAWDATA2MAINVAR.tabledata = [];
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
                                            P2INPUTRAWDATA2MAINVAR.LOCATION,
                                        "Plant": P2INPUTRAWDATA2MAINVAR.PLANT,
                                        "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                                        "CP": _data.CPMAT,
                                        "FG": _data.FGMAT,
                                        "ItemsCode": "",
                                        "ItemsName": "",
                                        "NUMBER": P2INPUTRAWDATA2MAINVAR.NUMBER,
                                        "POINT": P2INPUTRAWDATA2MAINVAR.POINT,
                                        "Data": P2INPUTRAWDATA2MAINVAR.DATASET,
                                        "Picture": "",
                                        "UserInput": USERDATA.ID,
                                        "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                        "SP02": P2INPUTRAWDATA2MAINVAR.ITEMs,

                                        "INSTRUMENT":
                                            P2INPUTRAWDATA2MAINVAR.INSTRUMENT,

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
                                      P2INPUTRAWDATA2MAINVAR.DATASET = '';
                                      Dio().post(
                                        "http://172.23.10.40:1900/" + "getdata",
                                        data: {
                                          "INS":
                                              P2INPUTRAWDATA2MAINVAR.INSTRUMENT,
                                          "NO": P2INPUTRAWDATA2MAINVAR.POINT,
                                          "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                          "LOCATION":
                                              P2INPUTRAWDATA2MAINVAR.LOCATION,
                                          "PLANT": P2INPUTRAWDATA2MAINVAR.PLANT,
                                        },
                                      ).then((v) {
                                        var databuff = v.data;
                                        print(databuff);
                                        if (databuff['DATA'] != null) {
                                          P2INPUTRAWDATA2MAINVAR.DATASET =
                                              databuff['DATA'].toString();
                                          setState(() {});
                                        }
                                      });
                                      P2INPUTRAWDATA2MAINVAR.tabledata = [];
                                      Dio().post(
                                        GLOserverRAW + "RAWDATA/getdata",
                                        data: {
                                          "Order": P2INPUTRAWDATA2MAINVAR.ORDER,
                                          "NUMBER":
                                              P2INPUTRAWDATA2MAINVAR.NUMBER,
                                          "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                        },
                                      ).then((v) {
                                        var databuff = v.data;
                                        P2INPUTRAWDATA2MAINVAR.DATASET = '';
                                        if (databuff.length > 0) {
                                          for (var i = 0;
                                              i < databuff.length;
                                              i++) {
                                            //
                                            P2INPUTRAWDATA2MAINVAR.tabledata
                                                .add(TABLECLASSclass(
                                                    // NO: (i + 1).toString(),
                                                    NO: (databuff.length - i)
                                                        .toString(),
                                                    DATA: databuff[i]['Data']));
                                          }

                                          P2INPUTRAWDATA2MAINVAR.POINT =
                                              (databuff.length).toString();
                                        } else {
                                          P2INPUTRAWDATA2MAINVAR.tabledata = [];
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
                                  if (P2INPUTRAWDATA2MAINVAR.AUTOGET ==
                                      'auto') {
                                    P2INPUTRAWDATA2MAINVAR.AUTOGET = '';
                                    P2INPUTRAWDATA2MAINVAR.DHtimer.cancel();
                                    setState(() {});
                                  } else {
                                    P2INPUTRAWDATA2MAINVAR.AUTOGET = 'auto';

                                    // Timer timer =
                                    //     Timer(const Duration(seconds: 1), () {
                                    //   //
                                    //   Dio().post(
                                    //     "http://172.23.10.40:1900/" + "getdata",
                                    //     data: {
                                    //       "INS":
                                    //           P2INPUTRAWDATA2MAINVAR.INSTRUMENT,
                                    //       "NO": P2INPUTRAWDATA2MAINVAR.POINT,
                                    //       "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                    //       "LOCATION":
                                    //           P2INPUTRAWDATA2MAINVAR.LOCATION,
                                    //       "PLANT": P2INPUTRAWDATA2MAINVAR.PLANT,
                                    //     },
                                    //   ).then((v) {
                                    //     var databuff = v.data;
                                    //     // print(databuff);
                                    //     if (databuff['DATA'] != null) {
                                    //       P2INPUTRAWDATA2MAINVAR.DATASET =
                                    //           databuff['DATA'].toString();
                                    //       setState(() {});

                                    //       P2INPUTRAWDATA2MAINVAR.tabledata = [];
                                    //       Dio().post(
                                    //         GLOserverRAW + "RAWDATA/getdata",
                                    //         data: {
                                    //           "Order":
                                    //               P2INPUTRAWDATA2MAINVAR.ORDER,
                                    //           "NUMBER":
                                    //               P2INPUTRAWDATA2MAINVAR.NUMBER,
                                    //           "TYPE": P2INPUTRAWDATA2MAINVAR.SPC,
                                    //         },
                                    //       ).then((v) {
                                    //         var databuff = v.data;

                                    //         if (databuff.length > 0) {
                                    //           for (var i = 0;
                                    //               i < databuff.length;
                                    //               i++) {
                                    //             //
                                    //             P2INPUTRAWDATA2MAINVAR.tabledata
                                    //                 .add(TABLECLASSclass(
                                    //                     // NO: (i + 1).toString(),
                                    //                     NO: (databuff.length -
                                    //                             i)
                                    //                         .toString(),
                                    //                     DATA: databuff[i]
                                    //                         ['Data']));
                                    //           }

                                    //           P2INPUTRAWDATA2MAINVAR.POINT =
                                    //               (databuff.length).toString();
                                    //           setState(() {});
                                    //         } else {
                                    //           P2INPUTRAWDATA2MAINVAR.tabledata =
                                    //               [];
                                    //           setState(() {});
                                    //         }
                                    //       });
                                    //     }
                                    //   });
                                    // });
                                    // P2INPUTRAWDATA2MAINVAR.DHtimer = timer;

                                    setState(() {});
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 40,
                                    width: 150,
                                    color:
                                        P2INPUTRAWDATA2MAINVAR.AUTOGET == 'auto'
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
                              //     P2INPUTRAWDATA2MAINVAR.NUMBER =
                              //         (int.parse(P2INPUTRAWDATA2MAINVAR.NUMBER) +
                              //                 1)
                              //             .toString();
                              //     P2INPUTRAWDATA2MAINVAR.POINT = '0';
                              //     P2INPUTRAWDATA2MAINVAR.tabledata = [];
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
                                    if (P2INPUTRAWDATA2MAINVAR.DATATYPE == '' ||
                                        P2INPUTRAWDATA2MAINVAR.DATATYPE ==
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
                                                  P2INPUTRAWDATA2MAINVAR
                                                      .DATASET,
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
                                                            P2INPUTRAWDATA2MAINVAR
                                                                .tabledata
                                                                .length;
                                                        i++) ...[
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: rowbox_type0(
                                                              Head:
                                                                  P2INPUTRAWDATA2MAINVAR
                                                                      .tabledata[
                                                                          i]
                                                                      .NO,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: rowbox_type0(
                                                              Head:
                                                                  P2INPUTRAWDATA2MAINVAR
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
                                                P2INPUTRAWDATA2MAINVAR.Pimg =
                                                    base64.encode(resizedData!);

                                                //----------------------------------------------------------
                                                // Dio().post(
                                                //   serverGB + "SIGNATURE_UPLOAD",
                                                //   data: {
                                                //     "ID": USERDATA.ID,
                                                //     "SIGNATURE":
                                                //         P2INPUTRAWDATA2MAINVAR
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

                                          if ((P2INPUTRAWDATA2MAINVAR.Pimg) !=
                                              '') ...[
                                            PicShowW(
                                              base64:
                                                  P2INPUTRAWDATA2MAINVAR.Pimg,
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
