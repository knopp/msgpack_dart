import 'dart:async';
import 'dart:typed_data';

import 'package:async/async.dart';
import "package:msgpack_dart/msgpack_dart.dart";
import 'package:test/test.dart';

//
// Tests taken from msgpack2 (https://github.com/butlermatt/msgpack2)
//

var isString = predicate((e) => e is String, 'is a String');
var isInt = predicate((e) => e is int, 'is an int');
var isMap = predicate((e) => e is Map, 'is a Map');
var isList = predicate((e) => e is List, 'is a List');

void main() {
  test("Test Stream-pack null", packNull);

  group("Test Stream-pack Boolean", () {
    test("Stream-pack boolean false", packFalse);
    test("Stream-pack boolean true", packTrue);
  });

  group("Test Stream-pack Ints", () {
    test("Stream-pack Positive FixInt", packPositiveFixInt);
    test("Stream-pack Negative FixInt", packFixedNegative);
    test("Stream-pack Uint8", packUint8);
    test("Stream-pack Uint16", packUint16);
    test("Stream-pack Uint32", packUint32);
    test("Stream-pack Uint64", packUint64);
    test("Stream-pack Int8", packInt8);
    test("Stream-pack Int16", packInt16);
    test("Stream-pack Int32", packInt32);
    test("Stream-pack Int64", packInt64);
  });

  group("Test Stream-pack Floats", () {
    test("Stream-pack Float32", packFloat32);
    test("Stream-pack Float64 (double)", packDouble);
  });

  test("Stream-pack 5-character string", packString5);
  test("Stream-pack 22-character string", packString22);
  test("Stream-pack 256-character string", packString256);
  test("Stream-pack string array", packStringArray);
  test("Stream-pack int-to-string map", packIntToStringMap);

  group("Test Stream-pack Binary", () {
    test("Stream-pack Bin8", packBin8);
    test("Stream-pack Bin16", packBin16);
    test("Stream-pack Bin32", packBin32);
    test("Stream-pack ByteData", packByteData);
  });

  group("Test Stream-pack multiple objects", () {
    test("Stream-pack multiple nulls", packMultipleNulls);
    test("Stream-pack multiple booleans", packMultipleBooleans);
    test("Stream-pack multiple integers", packMultipleIntegers);
    test("Stream-pack multiple floats", packMultipleFloats);
    test("Stream-pack multiple strings", packMultipleStrings);
    test("Stream-pack multiple binaries", packMultipleBinaries);
    test("Stream-pack multiple arrays", packMultipleArrays);
    test("Stream-pack multiple maps", packMultipleMaps);
    test("Stream-pack multiple dynamics", packMultipleDynamics);
  });

  group("Test Stream-unpack stream behavior", () {
    test("Stream-unpack should stop on end of stream", unpackStreamEnd);
    test("Stream-unpack should throw on abrupt end of stream",
        unpackStreamAbruptEndThrows);
  });

  test("Test Stream-unpack Null", unpackNull);

  group("Test Stream-unpack boolean", () {
    test("Stream-unpack boolean false", unpackFalse);
    test("Stream-unpack boolean true", unpackTrue);
  });

  group("Test Stream-unpack Ints", () {
    test("Stream-unpack Positive FixInt", unpackPositiveFixInt);
    test("Stream-unpack Negative FixInt", unpackNegativeFixInt);
    test("Stream-unpack Uint8", unpackUint8);
    test("Stream-unpack Uint16", unpackUint16);
    test("Stream-unpack Uint32", unpackUint32);
    test("Stream-unpack Uint64", unpackUint64);
    test("Stream-unpack Int8", unpackInt8);
    test("Stream-unpack Int16", unpackInt16);
    test("Stream-unpack Int32", unpackInt32);
    test("Stream-unpack Int64", unpackInt64);
  });

  group("Test Stream-unpack Floats", () {
    test("Stream-unpack Float32", unpackFloat32);
    test("Stream-unpack Float64 (double)", unpackDouble);
  });

  test("Stream-unpack 5-character string", unpackString5);
  test("Stream-unpack 22-character string", unpackString22);
  test("Stream-unpack 256-character string", unpackString256);
  test("Stream-unpack string array", unpackStringArray);
  test("Stream-unpack int-to-string map", unpackIntToStringMap);

  group("Test Stream-unpack Large Array and Map", () {
    test("Stream-unpack Large Array", largeArray);
    test("Stream-unpack Very Large Array", veryLargeArray);
    test("Stream-unpack Large Map", largeMap);
    test("Stream-unpack Very Large Map", veryLargeMap);
  });

  group("Test Stream-unpack multiple objects", () {
    test("Stream-unpack multiple nulls", unpackMultipleNulls);
    test("Stream-unpack multiple booleans", unpackMultipleBooleans);
    test("Stream-unpack multiple integers", unpackMultipleIntegers);
    test("Stream-unpack multiple floats", unpackMultipleFloats);
    test("Stream-unpack multiple strings", unpackMultipleStrings);
    test("Stream-unpack multiple binaries", unpackMultipleBinaries);
    test("Stream-unpack multiple arrays", unpackMultipleArrays);
    test("Stream-unpack multiple maps", unpackMultipleMaps);
    test("Stream-unpack multiple dynamics", unpackMultipleDynamics);
  });

  group("Test Stream-unpack from chunks", () {
    test("Stream-unpack multiple dynamics from chunks",
        unpackMultipleDynamicsFromChunks);
  });
}

Future<Uint8List> streamPack(Iterable objects) async {
  final stream = Stream.fromIterable(objects).transform(StreamSerializer());
  final bytes = await collectBytes(stream);
  return bytes;
}

Future<void> largeArray() async {
  final list = <String>[];
  for (int i = 0; i < 16; ++i) {
    list.add("Item $i");
  }

  final serialized = await streamPack([list]);
  List deserialized = deserialize(Uint8List.fromList(serialized));
  expect(deserialized, list);
}

Future<void> veryLargeArray() async {
  final list = <String>[];
  for (int i = 0; i < 65536; ++i) {
    list.add("Item $i");
  }

  final serialized = await streamPack([list]);
  List deserialized = deserialize(serialized);
  expect(deserialized, list);
}

Future<void> largeMap() async {
  final map = Map<int, String>();
  for (int i = 0; i < 16; ++i) {
    map[i] = "Item $i";
  }
  final serialized = await streamPack([map]);
  Map deserialized = deserialize(serialized);
  expect(deserialized, map);
}

Future<void> veryLargeMap() async {
  final map = Map<int, String>();
  for (int i = 0; i < 65536; ++i) {
    map[i] = "Item $i";
  }
  final serialized = await streamPack([map]);
  Map deserialized = deserialize(serialized);
  expect(deserialized, map);
}

Future<void> packNull() async {
  List<int> encoded = await streamPack([null]);
  expect(encoded, orderedEquals([0xc0]));
}

Future<void> packFalse() async {
  List<int> encoded = await streamPack([false]);
  expect(encoded, orderedEquals([0xc2]));
}

Future<void> packTrue() async {
  List<int> encoded = await streamPack([true]);
  expect(encoded, orderedEquals([0xc3]));
}

Future<void> packPositiveFixInt() async {
  List<int> encoded = await streamPack([1]);
  expect(encoded, orderedEquals([1]));
}

Future<void> packFixedNegative() async {
  List<int> encoded = await streamPack([-16]);
  expect(encoded, orderedEquals([240]));
}

Future<void> packUint8() async {
  List<int> encoded = await streamPack([128]);
  expect(encoded, orderedEquals([204, 128]));
}

Future<void> packUint16() async {
  List<int> encoded = await streamPack([32768]);
  expect(encoded, orderedEquals([205, 128, 0]));
}

Future<void> packUint32() async {
  List<int> encoded = await streamPack([2147483648]);
  expect(encoded, orderedEquals([206, 128, 0, 0, 0]));
}

Future<void> packUint64() async {
  List<int> encoded = await streamPack([9223372036854775807]);
  expect(encoded, orderedEquals([207, 127, 255, 255, 255, 255, 255, 255, 255]));
}

Future<void> packInt8() async {
  List<int> encoded = await streamPack([-128]);
  expect(encoded, orderedEquals([208, 128]));
}

Future<void> packInt16() async {
  List<int> encoded = await streamPack([-32768]);
  expect(encoded, orderedEquals([209, 128, 0]));
}

Future<void> packInt32() async {
  List<int> encoded = await streamPack([-2147483648]);
  expect(encoded, orderedEquals([210, 128, 0, 0, 0]));
}

Future<void> packInt64() async {
  List<int> encoded = await streamPack([-9223372036854775808]);
  expect(encoded, orderedEquals([211, 128, 0, 0, 0, 0, 0, 0, 0]));
}

Future<void> packFloat32() async {
  List<int> encoded = await streamPack([Float(3.14)]);
  expect(encoded, orderedEquals([202, 64, 72, 245, 195]));
}

Future<void> packDouble() async {
  List<int> encoded = await streamPack([3.14]);
  expect(encoded,
      orderedEquals([0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f]));
}

Future<void> packString5() async {
  List<int> encoded = await streamPack(["hello"]);
  expect(encoded, orderedEquals([165, 104, 101, 108, 108, 111]));
}

Future<void> packString22() async {
  List<int> encoded = await streamPack(["hello there, everyone!"]);
  expect(
      encoded,
      orderedEquals([
        182,
        104,
        101,
        108,
        108,
        111,
        32,
        116,
        104,
        101,
        114,
        101,
        44,
        32,
        101,
        118,
        101,
        114,
        121,
        111,
        110,
        101,
        33
      ]));
}

Future<void> packString256() async {
  List<int> encoded = await streamPack([
    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  ]);
  expect(encoded, hasLength(259));
  expect(encoded.sublist(0, 3), orderedEquals([218, 1, 0]));
  expect(encoded.sublist(3, 259), everyElement(65));
}

Future<void> packBin8() async {
  var data = Uint8List.fromList(List.filled(32, 65));
  List<int> encoded = await streamPack([data]);
  expect(encoded.length, equals(34));
  expect(encoded.getRange(0, 2), orderedEquals([0xc4, 32]));
  expect(encoded.getRange(2, encoded.length), orderedEquals(data));
}

Future<void> packBin16() async {
  var data = Uint8List.fromList(List.filled(256, 65));
  List<int> encoded = await streamPack([data]);
  expect(encoded.length, equals(256 + 3));
  expect(encoded.getRange(0, 3), orderedEquals([0xc5, 1, 0]));
  expect(encoded.getRange(3, encoded.length), orderedEquals(data));
}

Future<void> packBin32() async {
  var data = Uint8List.fromList(List.filled(65536, 65));
  List<int> encoded = await streamPack([data]);
  expect(encoded.length, equals(65536 + 5));
  expect(encoded.getRange(0, 5), orderedEquals([0xc6, 0, 1, 0, 0]));
  expect(encoded.getRange(5, encoded.length), orderedEquals(data));
}

Future<void> packByteData() async {
  var data = ByteData.view(Uint8List.fromList(List.filled(32, 65)).buffer);
  List<int> encoded = await streamPack([data]);
  expect(encoded.length, equals(34));
  expect(encoded.getRange(0, 2), orderedEquals([0xc4, 32]));
  expect(encoded.getRange(2, encoded.length),
      orderedEquals(data.buffer.asUint8List()));
}

Future<void> packStringArray() async {
  List<int> encoded = await streamPack([
    ["one", "two", "three"]
  ]);
  expect(
      encoded,
      orderedEquals([
        147,
        163,
        111,
        110,
        101,
        163,
        116,
        119,
        111,
        165,
        116,
        104,
        114,
        101,
        101
      ]));
}

Future<void> packIntToStringMap() async {
  List<int> encoded = await streamPack([
    {1: "one", 2: "two"}
  ]);
  expect(encoded,
      orderedEquals([130, 1, 163, 111, 110, 101, 2, 163, 116, 119, 111]));
}

Future<void> packMultipleNulls() async {
  List<int> encoded = await streamPack([null, null, null]);
  expect(encoded, orderedEquals([0xc0, 0xc0, 0xc0]));
}

Future<void> packMultipleBooleans() async {
  List<int> encoded = await streamPack([
    false,
    true,
  ]);
  expect(
    encoded,
    orderedEquals([
      ...[0xc2],
      ...[0xc3],
    ]),
  );
}

Future<void> packMultipleIntegers() async {
  List<int> encoded = await streamPack([
    128,
    32768,
    2147483648,
    9223372036854775807,
    -128,
    -32768,
    -2147483648,
    -9223372036854775808,
  ]);
  expect(
    encoded,
    orderedEquals([
      ...[204, 128],
      ...[205, 128, 0],
      ...[206, 128, 0, 0, 0],
      ...[207, 127, 255, 255, 255, 255, 255, 255, 255],
      ...[208, 128],
      ...[209, 128, 0],
      ...[210, 128, 0, 0, 0],
      ...[211, 128, 0, 0, 0, 0, 0, 0, 0],
    ]),
  );
}

Future<void> packMultipleFloats() async {
  List<int> encoded = await streamPack([
    Float(3.14),
    3.14,
  ]);
  expect(
    encoded,
    orderedEquals([
      ...[202, 64, 72, 245, 195],
      ...[0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f],
    ]),
  );
}

Future<void> packMultipleStrings() async {
  List<int> encoded = await streamPack([
    "hello",
    "hello there, everyone!",
    "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"
  ]);
  const string1Serialized = [165, 104, 101, 108, 108, 111];
  const string2Serialized = [
    182,
    104,
    101,
    108,
    108,
    111,
    32,
    116,
    104,
    101,
    114,
    101,
    44,
    32,
    101,
    118,
    101,
    114,
    121,
    111,
    110,
    101,
    33
  ];
  expect(
    encoded,
    hasLength(string1Serialized.length + string2Serialized.length + 259),
  );
  expect(
    encoded.getRange(0, string1Serialized.length),
    orderedEquals(string1Serialized),
  );
  expect(
    encoded.getRange(string1Serialized.length,
        string1Serialized.length + string2Serialized.length),
    orderedEquals(string2Serialized),
  );
  final string3Serialized = encoded.sublist(
    string1Serialized.length + string2Serialized.length,
  );
  expect(string3Serialized.getRange(0, 3), orderedEquals([218, 1, 0]));
  expect(string3Serialized.getRange(3, 259), everyElement(65));
}

Future<void> packMultipleBinaries() async {
  final data1 = Uint8List.fromList(List.filled(32, 65));
  final data2 = Uint8List.fromList(List.filled(256, 65));
  final data3 = Uint8List.fromList(List.filled(65536, 65));
  final data4 = ByteData.view(Uint8List.fromList(List.filled(32, 65)).buffer);
  List<int> encoded = await streamPack([data1, data2, data3, data4]);
  expect(encoded.length, equals(32 + 2 + 256 + 3 + 65536 + 5 + 32 + 2));
  expect(encoded.getRange(0, 2), orderedEquals([0xc4, 32]));
  expect(encoded.getRange(2, 2 + data1.length), orderedEquals(data1));
  expect(encoded.getRange(32 + 2, 32 + 2 + 3), orderedEquals([0xc5, 1, 0]));
  expect(
    encoded.getRange(32 + 2 + 3, 32 + 2 + 3 + data2.length),
    orderedEquals(data2),
  );
  expect(
    encoded.getRange(32 + 2 + 256 + 3, 32 + 2 + 256 + 3 + 5),
    orderedEquals([0xc6, 0, 1, 0, 0]),
  );
  expect(
    encoded.getRange(32 + 2 + 256 + 3 + 5, 32 + 2 + 256 + 3 + 5 + data3.length),
    orderedEquals(data3),
  );
  expect(
    encoded.getRange(
      32 + 2 + 256 + 3 + 5 + 65536,
      32 + 2 + 256 + 3 + 5 + 65536 + 2,
    ),
    orderedEquals([0xc4, 32]),
  );
  expect(
    encoded.getRange(32 + 2 + 256 + 3 + 65536 + 5 + 2,
        32 + 2 + 256 + 3 + 65536 + 5 + 2 + data4.lengthInBytes),
    orderedEquals(data4.buffer.asUint8List()),
  );
}

Future<void> packMultipleArrays() async {
  final data = List.generate(3, (_) => ["one", "two", "three"]);
  List<int> encoded = await streamPack(data);
  final expectedSegmentBytes = [
    147,
    163,
    111,
    110,
    101,
    163,
    116,
    119,
    111,
    165,
    116,
    104,
    114,
    101,
    101
  ];
  Iterable<int> repeatedBytes = Iterable.empty();
  for (int i = 0; i < data.length; i++) {
    repeatedBytes = repeatedBytes.followedBy(expectedSegmentBytes);
  }
  expect(encoded, orderedEquals(repeatedBytes));
}

Future<void> packMultipleMaps() async {
  final data = List.generate(3, (_) => {1: "one", 2: "two"});
  List<int> encoded = await streamPack(data);
  final expectedSegmentBytes = [
    130,
    1,
    163,
    111,
    110,
    101,
    2,
    163,
    116,
    119,
    111
  ];
  Iterable<int> repeatedBytes = Iterable.empty();
  for (int i = 0; i < data.length; i++) {
    repeatedBytes = repeatedBytes.followedBy(expectedSegmentBytes);
  }
  expect(encoded, orderedEquals(repeatedBytes));
}

Future<void> packMultipleDynamics() async {
  List<int> encoded = await streamPack([
    null,
    true,
    9223372036854775807,
    -9223372036854775808,
    Float(3.14),
    3.14,
    "hello there, everyone!",
    Uint8List.fromList(List.filled(65536, 65)),
    ByteData.view(Uint8List.fromList(List.filled(32, 65)).buffer),
    ["one", "two", "three"],
    {1: "one", 2: "two"},
  ]);
  expect(
    encoded,
    orderedEquals([
      ...[0xc0],
      ...[0xc3],
      ...[207, 127, 255, 255, 255, 255, 255, 255, 255],
      ...[211, 128, 0, 0, 0, 0, 0, 0, 0],
      ...[202, 64, 72, 245, 195],
      ...[0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f],
      ...[
        182,
        104,
        101,
        108,
        108,
        111,
        32,
        116,
        104,
        101,
        114,
        101,
        44,
        32,
        101,
        118,
        101,
        114,
        121,
        111,
        110,
        101,
        33
      ],
      ...[0xc6, 0, 1, 0, 0, ...List.filled(65536, 65)],
      ...[0xc4, 32, ...List.filled(32, 65)],
      ...[
        147,
        163,
        111,
        110,
        101,
        163,
        116,
        119,
        111,
        165,
        116,
        104,
        114,
        101,
        101
      ],
      ...[130, 1, 163, 111, 110, 101, 2, 163, 116, 119, 111],
    ]),
  );
}

// Test unpacking
Future<List<dynamic>> streamUnpack(Iterable<Uint8List> dataChunks) async {
  final stream =
      Stream.fromIterable(dataChunks).transform(StreamDeserializer().cast());
  final result = await stream.toList();
  return result;
}

Future<void> unpackStreamEnd() async {
  final toEmit = Uint8List.fromList([0xc3]);
  final streamController = StreamController<Uint8List>();
  final stream = streamController.stream.transform(StreamDeserializer().cast());
  streamController.add(toEmit);
  final closeFuture = streamController.close();
  await expectLater(
    stream,
    emitsInOrder([
      emits(true),
      emitsDone,
    ]),
  );
  await expectLater(closeFuture, completes);
}

Future<void> unpackStreamAbruptEndThrows() async {
  final toEmit = Uint8List.fromList([
    165,
    104,
    101,
    108,
    // 108,
    // 111,
  ]); // String of hello
  final streamController = StreamController<Uint8List>();
  final stream = streamController.stream.transform(StreamDeserializer().cast());
  streamController.add(toEmit);
  final closeFuture = streamController.close();
  await expectLater(
    stream,
    emitsInOrder([
      neverEmits(equals("hello")),
      emitsError(isA<UpstreamClosedError>()),
      emitsDone,
    ]),
  );
  await expectLater(closeFuture, completes);
}

Future<void> unpackNull() async {
  Uint8List data = new Uint8List.fromList([0xc0]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isNull);
}

Future<void> unpackFalse() async {
  Uint8List data = Uint8List.fromList([0xc2]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isFalse);
}

Future<void> unpackTrue() async {
  Uint8List data = Uint8List.fromList([0xc3]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isTrue);
}

Future<void> unpackString5() async {
  Uint8List data = new Uint8List.fromList([165, 104, 101, 108, 108, 111]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isString);
  expect(value, equals("hello"));
}

Future<void> unpackString22() async {
  Uint8List data = new Uint8List.fromList([
    182,
    104,
    101,
    108,
    108,
    111,
    32,
    116,
    104,
    101,
    114,
    101,
    44,
    32,
    101,
    118,
    101,
    114,
    121,
    111,
    110,
    101,
    33
  ]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isString);
  expect(value, equals("hello there, everyone!"));
}

Future<void> unpackPositiveFixInt() async {
  Uint8List data = Uint8List.fromList([1]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(1));
}

Future<void> unpackNegativeFixInt() async {
  Uint8List data = Uint8List.fromList([240]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(-16));
}

Future<void> unpackUint8() async {
  Uint8List data = Uint8List.fromList([204, 128]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(128));
}

Future<void> unpackUint16() async {
  Uint8List data = Uint8List.fromList([205, 128, 0]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(32768));
}

Future<void> unpackUint32() async {
  Uint8List data = Uint8List.fromList([206, 128, 0, 0, 0]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(2147483648));
}

Future<void> unpackUint64() async {
  // Dart 2 doesn't support true Uint64 without using BigInt
  Uint8List data =
      Uint8List.fromList([207, 127, 255, 255, 255, 255, 255, 255, 255]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(9223372036854775807));
}

Future<void> unpackInt8() async {
  Uint8List data = Uint8List.fromList([208, 128]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(-128));
}

Future<void> unpackInt16() async {
  Uint8List data = Uint8List.fromList([209, 128, 0]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(-32768));
  data = Uint8List.fromList([0xd1, 0x04, 0xd2]);
  print(deserialize(data));
}

Future<void> unpackInt32() async {
  Uint8List data = Uint8List.fromList([210, 128, 0, 0, 0]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(-2147483648));
}

Future<void> unpackInt64() async {
  Uint8List data = Uint8List.fromList([211, 128, 0, 0, 0, 0, 0, 0, 0]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isInt);
  expect(value, equals(-9223372036854775808));
}

Future<void> unpackFloat32() async {
  Uint8List data = Uint8List.fromList([202, 64, 72, 245, 195]);
  var value = (await streamUnpack([data]))[0];
  expect((value as double).toStringAsPrecision(3), equals('3.14'));
}

Future<void> unpackDouble() async {
  Uint8List data = Uint8List.fromList(
      [0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f]);
  var value = (await streamUnpack([data]))[0];
  expect(value, equals(3.14));
}

Future<void> unpackString256() async {
  Uint8List data =
      new Uint8List.fromList([218, 1, 0]..addAll(new List.filled(256, 65)));
  var value = (await streamUnpack([data]))[0];
  expect(value, isString);
  expect(
      value,
      equals(
          "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"));
}

Future<void> unpackStringArray() async {
  Uint8List data = new Uint8List.fromList([
    147,
    163,
    111,
    110,
    101,
    163,
    116,
    119,
    111,
    165,
    116,
    104,
    114,
    101,
    101
  ]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isList);
  expect(value, orderedEquals(["one", "two", "three"]));
}

Future<void> unpackIntToStringMap() async {
  Uint8List data = new Uint8List.fromList(
      [130, 1, 163, 111, 110, 101, 2, 163, 116, 119, 111]);
  var value = (await streamUnpack([data]))[0];
  expect(value, isMap);
  expect(value[1], equals("one"));
  expect(value[2], equals("two"));
}

Future<void> unpackSmallDateTime() async {
  var data = <int>[0xd7, 0xff, 0, 0, 0, 0, 0, 0, 0, 0];
  var value = (await streamUnpack([Uint8List.fromList(data)]))[0];
  expect(value, equals(DateTime.fromMillisecondsSinceEpoch(0)));
  data = <int>[0xd7, 0xff, 47, 175, 8, 0, 91, 124, 180, 16];
  value = (await streamUnpack([Uint8List.fromList(data)]))[0];
  expect((value as DateTime).toUtc(),
      equals(DateTime.utc(2018, 8, 22, 0, 56, 56, 200)));
}

Future<void> unpackPastDate() async {
  var data = <int>[
    0xc7,
    12,
    0xff,
    29,
    205,
    101,
    0,
    255,
    255,
    255,
    255,
    184,
    204,
    121,
    158
  ];

  var value = (await streamUnpack([Uint8List.fromList(data)]))[0] as DateTime;
  expect(value.toUtc(), equals(DateTime.utc(1932, 2, 24, 1, 53, 45, 500)));

  data = <int>[
    199,
    12,
    255,
    0,
    0,
    0,
    0,
    255,
    255,
    255,
    255,
    255,
    255,
    248,
    248
  ];
  value = (await streamUnpack([Uint8List.fromList(data)]))[0];
  expect(value.toUtc(), equals(DateTime.utc(1969, 12, 31, 23, 30)));
}

Future<void> unpackMultipleNulls() async {
  Uint8List data = new Uint8List.fromList([0xc0, 0xc0, 0xc0]);
  var value = await streamUnpack([data]);
  expect(value, orderedEquals([null, null, null]));
}

Future<void> unpackMultipleBooleans() async {
  Uint8List data = new Uint8List.fromList([0xc2, 0xc3]);
  var value = await streamUnpack([data]);
  expect(value, orderedEquals([false, true]));
}

Future<void> unpackMultipleIntegers() async {
  Uint8List data = new Uint8List.fromList([
    ...[1],
    ...[240],
    ...[204, 128],
    ...[205, 128, 0],
    ...[206, 128, 0, 0, 0],
    ...[207, 127, 255, 255, 255, 255, 255, 255, 255],
    ...[208, 128],
    ...[209, 128, 0],
    ...[210, 128, 0, 0, 0],
    ...[211, 128, 0, 0, 0, 0, 0, 0, 0],
  ]);
  var value = await streamUnpack([data]);
  expect(
    value,
    orderedEquals([
      1,
      -16,
      128,
      32768,
      2147483648,
      9223372036854775807,
      -128,
      -32768,
      -2147483648,
      -9223372036854775808,
    ]),
  );
}

Future<void> unpackMultipleFloats() async {
  Uint8List data = new Uint8List.fromList([
    ...[202, 64, 72, 245, 195],
    ...[0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f],
  ]);
  var value = await streamUnpack([data]);
  expect(value, hasLength(2));
  expect((value[0] as double).toStringAsPrecision(3), equals('3.14'));
  expect(value[1], equals(3.14));
}

Future<void> unpackMultipleStrings() async {
  Uint8List data = new Uint8List.fromList([
    ...[165, 104, 101, 108, 108, 111],
    ...[
      182,
      104,
      101,
      108,
      108,
      111,
      32,
      116,
      104,
      101,
      114,
      101,
      44,
      32,
      101,
      118,
      101,
      114,
      121,
      111,
      110,
      101,
      33
    ],
    ...Uint8List.fromList([218, 1, 0]..addAll(new List.filled(256, 65)))
  ]);
  var value = await streamUnpack([data]);
  expect(
    value,
    orderedEquals([
      "hello",
      "hello there, everyone!",
      "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
    ]),
  );
}

Future<void> unpackMultipleBinaries() async {
  Uint8List data = new Uint8List.fromList([
    ...[0xc4, 32, ...List.filled(32, 65)],
    ...[0xc5, 1, 0, ...List.filled(256, 65)],
    ...[0xc6, 0, 1, 0, 0, ...List.filled(65536, 65)],
  ]);
  var value = await streamUnpack([data]);
  expect(value, hasLength(3));
  expect(value[0], orderedEquals(Uint8List.fromList(List.filled(32, 65))));
  expect(value[1], orderedEquals(Uint8List.fromList(List.filled(256, 65))));
  expect(value[2], orderedEquals(Uint8List.fromList(List.filled(65536, 65))));
}

Future<void> unpackMultipleArrays() async {
  final segmentBytes = [
    147,
    163,
    111,
    110,
    101,
    163,
    116,
    119,
    111,
    165,
    116,
    104,
    114,
    101,
    101
  ];
  const segmentCount = 3;
  Iterable<int> data = Iterable.empty();
  for (var i = 0; i < segmentCount; i++) {
    data = data.followedBy(segmentBytes);
  }
  var value = await streamUnpack([Uint8List.fromList(data.toList())]);
  expect(value, hasLength(segmentCount));
  expect(value[0], orderedEquals(["one", "two", "three"]));
  expect(value[1], orderedEquals(["one", "two", "three"]));
  expect(value[2], orderedEquals(["one", "two", "three"]));
}

Future<void> unpackMultipleMaps() async {
  final segmentBytes = [130, 1, 163, 111, 110, 101, 2, 163, 116, 119, 111];
  const segmentCount = 3;
  Iterable<int> data = Iterable.empty();
  for (var i = 0; i < segmentCount; i++) {
    data = data.followedBy(segmentBytes);
  }
  var value = await streamUnpack([Uint8List.fromList(data.toList())]);
  expect(value, hasLength(segmentCount));
  for (var i = 0; i < segmentCount; i++) {
    expect(value[i], isMap);
    expect(value[i], hasLength(2));
    expect(value[i][1], equals("one"));
    expect(value[i][2], equals("two"));
  }
}

Future<void> unpackMultipleDynamics() async {
  final data = Uint8List.fromList([
    ...[0xc0],
    ...[0xc2],
    ...[0xc3],
    ...[207, 127, 255, 255, 255, 255, 255, 255, 255],
    ...[211, 128, 0, 0, 0, 0, 0, 0, 0],
    ...[202, 64, 72, 245, 195],
    ...[0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f],
    ...[165, 104, 101, 108, 108, 111],
    ...[
      182,
      104,
      101,
      108,
      108,
      111,
      32,
      116,
      104,
      101,
      114,
      101,
      44,
      32,
      101,
      118,
      101,
      114,
      121,
      111,
      110,
      101,
      33
    ],
    ...[0xc4, 32, ...List.filled(32, 65)],
    ...[
      147,
      163,
      111,
      110,
      101,
      163,
      116,
      119,
      111,
      165,
      116,
      104,
      114,
      101,
      101
    ],
    ...[130, 1, 163, 111, 110, 101, 2, 163, 116, 119, 111],
  ]);
  final value = await streamUnpack([data]);
  final expectedValues = [
    null,
    false,
    true,
    9223372036854775807,
    -9223372036854775808,
    3.14, // f32
    3.14, // f64
    "hello",
    "hello there, everyone!",
    Uint8List.fromList(List.filled(32, 65)),
    ["one", "two", "three"],
    {1: "one", 2: "two"},
  ];
  expect(value, hasLength(expectedValues.length));
  expect(value[0], equals(expectedValues[0]));
  expect(value[1], equals(expectedValues[1]));
  expect(value[2], equals(expectedValues[2]));
  expect(value[3], equals(expectedValues[3]));
  expect(value[4], equals(expectedValues[4]));
  expect(
    (value[5] as double).toStringAsPrecision(3),
    equals(expectedValues[5].toString()),
  );
  expect(value[6], equals(expectedValues[6]));
  expect(value[7], equals(expectedValues[7]));
  expect(value[8], equals(expectedValues[8]));
  expect(value[9], orderedEquals(expectedValues[9] as Uint8List));
  expect(value[10], orderedEquals(expectedValues[10] as List));
  expect(value[11], equals(expectedValues[11]));
}

Future<void> unpackMultipleDynamicsFromChunks() async {
  final data = Uint8List.fromList([
    ...[0xc0],
    ...[0xc2],
    ...[0xc3],
    ...[207, 127, 255, 255, 255, 255, 255, 255, 255],
    ...[211, 128, 0, 0, 0, 0, 0, 0, 0],
    ...[202, 64, 72, 245, 195],
    ...[0xcb, 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f],
    ...[165, 104, 101, 108, 108, 111],
    ...[
      182,
      104,
      101,
      108,
      108,
      111,
      32,
      116,
      104,
      101,
      114,
      101,
      44,
      32,
      101,
      118,
      101,
      114,
      121,
      111,
      110,
      101,
      33
    ],
    ...[0xc4, 32, ...List.filled(32, 65)],
    ...[
      147,
      163,
      111,
      110,
      101,
      163,
      116,
      119,
      111,
      165,
      116,
      104,
      114,
      101,
      101
    ],
    ...[130, 1, 163, 111, 110, 101, 2, 163, 116, 119, 111],
  ]);
  final chunkedData = <Uint8List>[];
  const chunkSize = 5;
  for (var i = 0; i < data.length; i += chunkSize) {
    final endAt = i + chunkSize;
    chunkedData.add(data.sublist(i, endAt > data.length ? data.length : endAt));
  }
  final value = await streamUnpack(chunkedData);
  final expectedValues = [
    null,
    false,
    true,
    9223372036854775807,
    -9223372036854775808,
    3.14, // f32
    3.14, // f64
    "hello",
    "hello there, everyone!",
    Uint8List.fromList(List.filled(32, 65)),
    ["one", "two", "three"],
    {1: "one", 2: "two"},
  ];
  expect(value, hasLength(expectedValues.length));
  expect(value[0], equals(expectedValues[0]));
  expect(value[1], equals(expectedValues[1]));
  expect(value[2], equals(expectedValues[2]));
  expect(value[3], equals(expectedValues[3]));
  expect(value[4], equals(expectedValues[4]));
  expect(
    (value[5] as double).toStringAsPrecision(3),
    equals(expectedValues[5].toString()),
  );
  expect(value[6], equals(expectedValues[6]));
  expect(value[7], equals(expectedValues[7]));
  expect(value[8], equals(expectedValues[8]));
  expect(value[9], orderedEquals(expectedValues[9] as Uint8List));
  expect(value[10], orderedEquals(expectedValues[10] as List));
  expect(value[11], equals(expectedValues[11]));
}
