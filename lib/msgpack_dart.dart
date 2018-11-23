library msgpack_dart;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

part 'src/common.dart';
part 'src/data_builder.dart';
part 'src/serializer.dart';
part 'src/deserializer.dart';

List<int> serialize(dynamic value, {ExtEncoder extEncoder}) {
  final s = Serializer(extEncoder: extEncoder);
  s.encode(value);
  return s.takeBytes();
}

dynamic deserialize(Uint8List list, {ExtDecoder extDecoder}) {
  final d = Deserializer(list, extDecoder: extDecoder);
  return d.decode();
}
