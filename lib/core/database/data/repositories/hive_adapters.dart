import 'package:hive/hive.dart';

class MapIntIntAdapter extends TypeAdapter<Map<int, int>> {
  @override
  final int typeId = 1; // Уникальный typeId для этого адаптера

  @override
  Map<int, int> read(BinaryReader reader) {
    print(1234234234);
    final length = reader.readInt();
    final map = <int, int>{};
    for (var i = 0; i < length; i++) {
      final key = reader.readInt();
      final value = reader.readInt();
      map[key] = value;
    }
    return map;
  }

  @override
  void write(BinaryWriter writer, Map<int, int> obj) {
    writer.writeInt(obj.length);
    obj.forEach((key, value) {
      writer.writeInt(key);
      writer.writeInt(value);
    });
  }
}
