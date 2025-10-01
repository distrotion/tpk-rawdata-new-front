import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/BlocEvent/ChangePageEvent.dart';

import '../../bloc/Cubit/ChangePageEventCUBIT.dart';
import '../../data/global.dart';
import '../../mainBody.dart';
import '../../widget/common/Loading.dart';

import '../P2INPUTRAWDATA2/P2INPUTRAWDATA2VAR.dart';
import '../page2.dart';
import '../page4.dart';

class P4SELECTPLANTmain extends StatelessWidget {
  const P4SELECTPLANTmain({super.key});

  @override
  Widget build(BuildContext context) {
    print(USERDATA.LOCATIONList);
    return SingleChildScrollView(
      child: Column(
        children: [
          if (USERDATA.LOCATIONList.toString().contains("HES-PH") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  print("object");
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'HES';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'GAS';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2300';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("PH HES"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("HES-PAL") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'HES';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'PAL';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2300';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("PAL HES"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("BP12-PAL") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'BP12';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'PAL';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("PAL BP12"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("BP12-PVD") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'BP12';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'PVD';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("PVD BP12"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("BP12-KNG") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'BP12';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'PVD';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("KNG BP12"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("BP12-PH") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'BP12';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'PH';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("PH BP12"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("HES-GAS") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'HES';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2300';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'GAS';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("HES GAS"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("GW-GAS") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'GW';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2200';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'GAS';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("GW GAS"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("BP12-GAS") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'BP12';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'GAS';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("BP12 GAS"),
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (USERDATA.LOCATIONList.toString().contains("HES-ISN") &&
              USERDATA.UserLV >= 5) ...[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: InkWell(
                onTap: () {
                  //
                  P2INPUTRAWDATA2MAINVAR.LOCATION = 'BP12';
                  P2INPUTRAWDATA2MAINVAR.LINKPLANT = 'getitem2100';
                  P2INPUTRAWDATA2MAINVAR.PLANT = 'GAS';
                  MainBodyContext.read<ChangePage_Bloc>()
                      .ChangePage_nodrower('', Page2());
                },
                child: Container(
                  height: 100,
                  width: 400,
                  color: Colors.blue,
                  child: Center(
                    child: Center(
                      child: Text("HES ISN"),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
