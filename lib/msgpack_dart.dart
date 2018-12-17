library msgpack_dart;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

part 'src/common.dart';
part 'src/data_writer.dart';
part 'src/serializer.dart';
part 'src/deserializer.dart';

List<int> serialize(
  dynamic value, {
  ExtEncoder extEncoder,
}) {
  final s = Serializer(extEncoder: extEncoder);
  s.encode(value);
  return s.takeBytes();
}

dynamic deserialize(Uint8List list,
    {ExtDecoder extDecoder, bool copyBinaryData = false}) {
  final d = Deserializer(list,
      extDecoder: extDecoder, copyBinaryData: copyBinaryData);
  return d.decode();
}
