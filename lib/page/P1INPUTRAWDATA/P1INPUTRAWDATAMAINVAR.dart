import '../../model/model.dart';

class P1INPUTRAWDATAMAINVAR {
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

  static String NUMBER = '0';
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
    // MapEntry("PVD", "PVD"),
    // MapEntry("KNG", "KNG"),
  ];
  static List<MapEntry<String, String>> plantGW = [
    MapEntry("", ""),
    MapEntry("GAS", "GAS"),
  ];
  static List<MapEntry<String, String>> plantHES = [
    MapEntry("", ""),
    MapEntry("GAS", "GAS"),
    MapEntry("PH", "PH"),
    MapEntry("PVD", "PVD"),
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
}
