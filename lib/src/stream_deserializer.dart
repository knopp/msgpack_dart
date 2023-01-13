part of msgpack_dart;

/// A [StreamTransformer] that deserializes [Uint8List]s into Dart objects,
/// using the MessagePack format.
class StreamDeserializer extends StreamTransformerBase<List<int>, dynamic> {
  final ExtDecoder? _extDecoder;

  /// If false, decoded binary data buffers will reference underlying input
  /// buffer and thus may change when the content of input buffer changes.
  ///
  /// If true, decoded buffers are copies and the underlying input buffer is
  /// free to change after decoding.
  final bool copyBinaryData;
  final Encoding codec;

  StreamDeserializer({
    ExtDecoder? extDecoder,
    this.copyBinaryData = false,
    this.codec = const Utf8Codec(),
  }) : _extDecoder = extDecoder;

  @override
  Stream<dynamic> bind(Stream<List<int>> stream) async* {
    final bytesChunkReader = ChunkedStreamReader(stream);

    var uByte = await bytesChunkReader.readBytes(1);
    while (uByte.isNotEmpty) {
      final u = uByte[0];
      yield await _decode(u, bytesChunkReader);
      uByte = await bytesChunkReader.readBytes(1);
    }
  }

  Future<dynamic> _decode(
    int u,
    ChunkedStreamReader<int> bytesChunkReader,
  ) async {
    if (u <= 127) {
      return u;
    } else if ((u & 0xE0) == 0xE0) {
      // negative small integer
      return u - 256;
    } else if ((u & 0xE0) == 0xA0) {
      return await _readString(bytesChunkReader, u & 0x1F);
    } else if ((u & 0xF0) == 0x90) {
      return await _readArray(bytesChunkReader, u & 0xF);
    } else if ((u & 0xF0) == 0x80) {
      return await _readMap(bytesChunkReader, u & 0xF);
    }
    switch (u) {
      case 0xc0:
        return null;
      case 0xc2:
        return false;
      case 0xc3:
        return true;
      case 0xcc:
        return await _readUInt8(bytesChunkReader);
      case 0xcd:
        return await _readUInt16(bytesChunkReader);
      case 0xce:
        return await _readUInt32(bytesChunkReader);
      case 0xcf:
        return await _readUInt64(bytesChunkReader);
      case 0xd0:
        return await _readInt8(bytesChunkReader);
      case 0xd1:
        return await _readInt16(bytesChunkReader);
      case 0xd2:
        return await _readInt32(bytesChunkReader);
      case 0xd3:
        return await _readInt64(bytesChunkReader);
      case 0xca:
        return await _readFloat(bytesChunkReader);
      case 0xcb:
        return await _readDouble(bytesChunkReader);
      case 0xd9:
        return await _readString(
            bytesChunkReader, await _readUInt8(bytesChunkReader));
      case 0xda:
        return await _readString(
            bytesChunkReader, await _readUInt16(bytesChunkReader));
      case 0xdb:
        return await _readString(
            bytesChunkReader, await _readUInt32(bytesChunkReader));
      case 0xc4:
        return await _readBuffer(
            bytesChunkReader, await _readUInt8(bytesChunkReader));
      case 0xc5:
        return await _readBuffer(
            bytesChunkReader, await _readUInt16(bytesChunkReader));
      case 0xc6:
        return await _readBuffer(
            bytesChunkReader, await _readUInt32(bytesChunkReader));
      case 0xdc:
        return await _readArray(
            bytesChunkReader, await _readUInt16(bytesChunkReader));
      case 0xdd:
        return await _readArray(
            bytesChunkReader, await _readUInt32(bytesChunkReader));
      case 0xde:
        return await _readMap(
            bytesChunkReader, await _readUInt16(bytesChunkReader));
      case 0xdf:
        return await _readMap(
            bytesChunkReader, await _readUInt32(bytesChunkReader));
      case 0xd4:
        return await _readExt(bytesChunkReader, 1);
      case 0xd5:
        return await _readExt(bytesChunkReader, 2);
      case 0xd6:
        return await _readExt(bytesChunkReader, 4);
      case 0xd7:
        return await _readExt(bytesChunkReader, 8);
      case 0xd8:
        return await _readExt(bytesChunkReader, 16);
      case 0xc7:
        return await _readExt(
            bytesChunkReader, await _readUInt8(bytesChunkReader));
      case 0xc8:
        return await _readExt(
            bytesChunkReader, await _readUInt16(bytesChunkReader));
      case 0xc9:
        return await _readExt(
            bytesChunkReader, await _readUInt32(bytesChunkReader));
      default:
        throw FormatError("Invalid MessagePack format");
    }
  }

  Future<int> _readInt8(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 1);
    return ByteData.sublistView(bytes).getInt8(0);
  }

  Future<int> _readUInt8(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 1);
    return ByteData.sublistView(bytes).getUint8(0);
  }

  Future<int> _readUInt16(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 2);
    return ByteData.sublistView(bytes).getUint16(0);
  }

  Future<int> _readInt16(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 2);
    return ByteData.sublistView(bytes).getInt16(0);
  }

  Future<int> _readUInt32(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 4);
    return ByteData.sublistView(bytes).getUint32(0);
  }

  Future<int> _readInt32(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 4);
    return ByteData.sublistView(bytes).getInt32(0);
  }

  Future<int> _readUInt64(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 8);
    return ByteData.sublistView(bytes).getUint64(0);
  }

  Future<int> _readInt64(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 8);
    return ByteData.sublistView(bytes).getInt64(0);
  }

  Future<double> _readFloat(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 4);
    return ByteData.sublistView(bytes).getFloat32(0);
  }

  Future<double> _readDouble(ChunkedStreamReader<int> bytesChunkReader) async {
    final bytes = await _expectBytes(bytesChunkReader, 8);
    return ByteData.sublistView(bytes).getFloat64(0);
  }

  Future<Uint8List> _readBuffer(
    ChunkedStreamReader<int> bytesChunkReader,
    int length,
  ) async {
    final bytes = await _expectBytes(bytesChunkReader, length);
    return copyBinaryData ? Uint8List.fromList(bytes) : bytes;
  }

  Future<String> _readString(
    ChunkedStreamReader<int> bytesChunkReader,
    int length,
  ) async {
    final list = await _readBuffer(bytesChunkReader, length);
    final len = list.length;
    for (int i = 0; i < len; ++i) {
      if (list[i] > 127) {
        return codec.decode(list);
      }
    }
    return String.fromCharCodes(list);
  }

  Future<List> _readArray(
    ChunkedStreamReader<int> bytesChunkReader,
    int length,
  ) async {
    final res = List<dynamic>.filled(length, null, growable: false);
    for (int i = 0; i < length; ++i) {
      final uByte = await _expectBytes(bytesChunkReader, 1);
      res[i] = await _decode(uByte[0], bytesChunkReader);
    }
    return res;
  }

  Future<Map> _readMap(
    ChunkedStreamReader<int> bytesChunkReader,
    int length,
  ) async {
    final res = Map();
    while (length > 0) {
      final uByteKey = await _expectBytes(bytesChunkReader, 1);
      final key = await _decode(uByteKey[0], bytesChunkReader);
      final uByteValue = await _expectBytes(bytesChunkReader, 1);
      final value = await _decode(uByteValue[0], bytesChunkReader);
      res[key] = value;
      --length;
    }
    return res;
  }

  Future<dynamic> _readExt(
    ChunkedStreamReader<int> bytesChunkReader,
    int length,
  ) async {
    final extType = await _readUInt8(bytesChunkReader);
    final data = await _readBuffer(bytesChunkReader, length);
    return _extDecoder?.decodeObject(extType, data);
  }

  Future<Uint8List> _expectBytes(
    ChunkedStreamReader<int> bytesChunkReader,
    int length,
  ) async {
    final bytes = await bytesChunkReader.readBytes(length);
    if (bytes.length != length) {
      throw const UpstreamClosedError();
    }
    return bytes;
  }
}
