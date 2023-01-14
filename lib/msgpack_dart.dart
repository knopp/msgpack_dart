library msgpack_dart;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:async/async.dart';

part 'src/common.dart';
part 'src/data_writer.dart';
part 'src/deserializer.dart';
part 'src/serializer.dart';
part 'src/stream_serializer.dart';
part 'src/stream_deserializer.dart';

Uint8List serialize(
  dynamic value, {
  ExtEncoder? extEncoder,
}) {
  final s = Serializer(extEncoder: extEncoder);
  s.encode(value);
  return s.takeBytes();
}

dynamic deserialize(
  Uint8List list, {
  ExtDecoder? extDecoder,
  bool copyBinaryData = false,
}) {
  final d = Deserializer(
    list,
    extDecoder: extDecoder,
    copyBinaryData: copyBinaryData,
  );
  return d.decode();
}
