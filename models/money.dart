import 'package:hive/hive.dart';

part 'money.g.dart';

@HiveType(typeId: 0)
class Money {
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  String price;
  @HiveField(4)
  String date;
  @HiveField(5)
  bool isReceived;
  @HiveField(6)
  int countref;
  @HiveField(7)
  String email;
  @HiveField(8)
  String tell;
  @HiveField(9)
  String service;

  Money({
    required this.id,
    required this.title,
    required this.price,
    required this.date,
    required this.isReceived,
    required this.countref,
    required this.email,
    required this.tell,
    required this.service,
  });
}

@HiveType(typeId: 1)
class Config {
  @HiveField(1)
  int lvl;
  bool? changed;

  Config({
    required this.lvl,
  });
}

@HiveType(typeId: 2)
class CandleD {
  @HiveField(1)
  double numD = 0;
  @HiveField(2)
  double monthD = 0;

  CandleD({required this.numD, required this.monthD});
}

@HiveType(typeId: 3)
class FTDE {
  @HiveField(1)
  int eF = 1;
  @HiveField(2)
  int dT = 1;
  FTDE({required this.eF, required this.dT});
}
