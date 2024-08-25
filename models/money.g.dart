// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'money.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoneyAdapter extends TypeAdapter<Money> {
  @override
  final int typeId = 0;

  @override
  Money read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Money(
      id: fields[1] as int,
      title: fields[2] as String,
      price: fields[3] as String,
      date: fields[4] as String,
      isReceived: fields[5] as bool,
      countref: fields[6] as int,
      email: fields[7] as String,
      tell: fields[8] as String,
      service: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Money obj) {
    writer
      ..writeByte(9)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.isReceived)
      ..writeByte(6)
      ..write(obj.countref)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.tell)
      ..writeByte(9)
      ..write(obj.service);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoneyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ConfigAdapter extends TypeAdapter<Config> {
  @override
  final int typeId = 1;

  @override
  Config read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Config(
      lvl: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Config obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.lvl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CandleDAdapter extends TypeAdapter<CandleD> {
  @override
  final int typeId = 2;

  @override
  CandleD read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CandleD(
      numD: fields[1] as double,
      monthD: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CandleD obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.numD)
      ..writeByte(2)
      ..write(obj.monthD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CandleDAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FTDEAdapter extends TypeAdapter<FTDE> {
  @override
  final int typeId = 3;

  @override
  FTDE read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FTDE(
      eF: fields[1] as int,
      dT: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FTDE obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.eF)
      ..writeByte(2)
      ..write(obj.dT);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FTDEAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
