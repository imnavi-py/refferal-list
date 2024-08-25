import 'package:hive_flutter/hive_flutter.dart';
import 'package:moaarefyar/widgets/controllers/daymonthcandle.dart';
import '../../models/money.dart';

//Load Farsi / English / Toman / Dollar
Future<void> loadFTDE() async {
  var box = await Hive.openBox<FTDE>('ftdeBox');
  FTDE? ftde = box.get('ftde');
  if (ftde != null) {
    userlvl.FaEn = ftde.eF;
    userlvl.TomanDollar = ftde.dT;
  }
}

//Save Farsi / English / Toman / Dollar
Future<void> saveFTDE() async {
  var box = await Hive.openBox<FTDE>('ftdeBox');
  FTDE ftde = FTDE(eF: userlvl.FaEn, dT: userlvl.TomanDollar);
  await box.put('ftde', ftde);
  print('yes');
}
