import 'dart:async';

import '../../model/model.dart';

class P2INPUTRAWDATA2MAINVAR {
  //
  static String AUTOGET = '';
  static late Timer DHtimer;
  //
  static bool iscontrol = false;
  static String LOCATION = '';

  static String PLANT = '';
  static String ORDER = '';

  static String INSTRUMENT = '';
  static String ITEMs = '';
  static String DATATYPE = '';

  static String Pimg = '';

  static String CPGET = '';

  static String DATASET = '';

  static String LINKPLANT = '';

  static String NUMBER = '1';
  static String POINT = '0';

  static List<MapEntry<String, String>> Plantlist = [
    MapEntry("", ""),
  ];
  static List<MapEntry<String, String>> ITEMslist = [
    MapEntry("", ""),
  ];

  static List<MapEntry<String, String>> INSTRUMENTlist = [
    MapEntry("", ""),
  ];

  static List<MapEntry<String, String>> blank = [
    MapEntry("", ""),
  ];

  static List<MapEntry<String, String>> plantBP12 = [
    MapEntry("", ""),
    MapEntry("GAS", "GAS"),
    MapEntry("PH", "PH"),
    MapEntry("PAL", "PAL"),
    MapEntry("PVD", "PVD"),
    MapEntry("KNG", "KNG"),
  ];
  static List<MapEntry<String, String>> plantGW = [
    MapEntry("", ""),
    MapEntry("GAS", "GAS"),
  ];
  static List<MapEntry<String, String>> plantHES = [
    MapEntry("", ""),
    MapEntry("GAS", "GAS"),
    MapEntry("PH", "PH"),
    MapEntry("DEL", "DEL"),
    MapEntry("PAL", "PAL"),
    MapEntry("ISN", "ISN"),
  ];

  static List<MapEntry<String, String>> SPClist = [
    MapEntry("", ""),
    MapEntry("FINAL", "master_FN"),
    MapEntry("INPROCESS", "master_IP"),
    MapEntry("INCOMMING", "master_IC"),
  ];

  static String SPC = '';
  static String SPCdata = '';

  static List<TABLECLASSclass> tabledata = [];

  static List<MapEntry<String, String>> BP12GAS = [
    MapEntry("", ""),
    MapEntry("GAS-OHR-001", "GAS-OHR-001"),
    MapEntry("GAS-RHT-001", "GAS-RHT-001"),
    MapEntry("GAS-VIC-001", "GAS-VIC-001"),
    MapEntry("GAS-HMV-001", "GAS-HMV-001"),
    MapEntry("GAS-HMV-002", "GAS-HMV-002"),
    MapEntry("GAS-HMV-003", "GAS-HMV-003"),
  ];
  static List<MapEntry<String, String>> BP12PH = [
    MapEntry("", ""),
    MapEntry("SUR-THI-002", "SUR-THI-002"),
    MapEntry("SUR-MIC-001", "SUR-MIC-001"),
    MapEntry("SUR-RGH-001", "SUR-RGH-001"),
    MapEntry("SUR-BAL-013", "SUR-BAL-013"),
  ];
  static List<MapEntry<String, String>> BP12PAL = [
    MapEntry("", ""),
    MapEntry("SUR-THI-002", "SUR-THI-002"),
    MapEntry("SUR-MIC-001", "SUR-MIC-001"),
    MapEntry("SUR-RGH-001", "SUR-RGH-001"),
    MapEntry("SUR-BAL-013", "SUR-BAL-013"),
  ];
  static List<MapEntry<String, String>> BP12PVD = [
    MapEntry("", ""),
    MapEntry("SUR-THI-002", "SUR-THI-002"),
    MapEntry("SUR-MIC-001", "SUR-MIC-001"),
    MapEntry("SUR-RGH-001", "SUR-RGH-001"),
    MapEntry("SUR-BAL-013", "SUR-BAL-013"),
  ];
  static List<MapEntry<String, String>> BP12KNG = [
    MapEntry("", ""),
    MapEntry("PVD-SCT-001", "PVD-SCT-001"),
    MapEntry("CTC-XTM-001", "CTC-XTM-001"),
    MapEntry("GAS-HMV-001", "GAS-HMV-001"),
    MapEntry("GAS-HMV-002", "GAS-HMV-002"),
    MapEntry("GAS-HMV-003", "GAS-HMV-003"),
  ];
  static List<MapEntry<String, String>> GWGAS = [
    MapEntry("", ""),
    MapEntry("TPG-HVK-003", "TPG-HVK-003"),
    MapEntry("TPG-HMV-002", "TPG-HMV-002"),
    MapEntry("TPG-HMV-003", "TPG-HMV-003"),
    MapEntry("TPG-HRC-004", "TPG-HRC-004"),
    MapEntry("TPG-HRC-005", "TPG-HRC-005"),
  ];
  static List<MapEntry<String, String>> HESGAS = [
    MapEntry("", ""),
    MapEntry("HG-HMV-001", "HG-HMV-001"),
    MapEntry("HG-HMV-002", "HG-HMV-002"),
    MapEntry("HG-HMV-003", "HG-HMV-003"),
    MapEntry("HG-VHT-001", "HG-VHT-001"),
    MapEntry("HG-HRC-002", "HG-HRC-002"),
  ];
  static List<MapEntry<String, String>> HESPH = [
    MapEntry("", ""),
    MapEntry("HS-THI-003", "HS-THI-003"),
    MapEntry("HS-MIC-003", "HS-MIC-003"),
    MapEntry("HS-RGH-001", "HS-RGH-001"),
    MapEntry("HS-EWB-008", "HS-EWB-008"),
  ];
  static List<MapEntry<String, String>> HESDEL = [
    MapEntry("", ""),
  ];
  static List<MapEntry<String, String>> HESPAL = [
    MapEntry("", ""),
    MapEntry("HP-MIC-001", "HP-MIC-001"),
    MapEntry("HP-MIC-002", "HP-MIC-002"),
    MapEntry("HP-THI-005", "HP-THI-005"),
    MapEntry("HP-THI-002", "HP-THI-002"),
    MapEntry("HP-THI-001", "HP-THI-001"),
    MapEntry("HP-EWB-008", "HP-EWB-008"),
  ];
  static List<MapEntry<String, String>> HESISN = [
    MapEntry("", ""),
    MapEntry("HI-HMV-001", "HI-HMV-001"),
    MapEntry("HI-HMV-002", "HI-HMV-002"),
    MapEntry("HI-RGH-001", "HI-RGH-001"),
    MapEntry("HI-MIC-001", "HI-MIC-001"),
  ];
}
