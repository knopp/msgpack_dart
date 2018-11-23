part of msgpack_dart;

abstract class ExtEncoder {
  // Return null if object can't be encoded
  int extTypeForObject(dynamic object);

  Uint8List encodeObject(dynamic object);
}

class Float {
  Float(this.value);

  final double value;

  @override
  String toString() => value.toString();
}

class Serializer {
  Serializer({
    ByteDataBuilder dataBuilder,
    ExtEncoder extEncoder,
  })  : _dataBuilder = dataBuilder ?? ByteDataBuilder(),
        _extEncoder = extEncoder;

  void encode(dynamic d) {
    if (d == null) return _dataBuilder.writeUint8(0xc0);
    if (d is bool) return _dataBuilder.writeUint8(d == true ? 0xc3 : 0xc2);
    if (d is int) return d >= 0 ? _writePositiveInt(d) : _writeNegativeInt(d);
    if (d is Float) return _writeFloat(d);
    if (d is double) return _writeDouble(d);
    if (d is String) return _writeString(d);
    if (d is Uint8List) return _writeBinary(d);
    if (d is List) return _writeArray(d);
    if (d is Map) return _writeMap(d);
    if (_extEncoder != null) {
      return _writeExt(d);
    }
  }

  List<int> takeBytes() {
    return _dataBuilder.takeBytes();
  }

  void _writeNegativeInt(int n) {
    if (n >= -32) {
      this._dataBuilder.writeInt8(n);
    } else if (n >= -128) {
      this._dataBuilder.writeUint8(0xd0);
      this._dataBuilder.writeInt8(n);
    } else if (n >= -32768) {
      this._dataBuilder.writeUint8(0xd1);
      this._dataBuilder.writeInt16(n);
    } else if (n >= -2147483648) {
      this._dataBuilder.writeUint8(0xd2);
      this._dataBuilder.writeInt32(n);
    } else {
      this._dataBuilder.writeUint8(0xd3);
      this._dataBuilder.writeInt64(n);
    }
  }

  void _writePositiveInt(int n) {
    if (n <= 127) {
      this._dataBuilder.writeUint8(n);
    } else if (n <= 0xFF) {
      this._dataBuilder.writeUint8(0xcc);
      this._dataBuilder.writeUint8(n);
    } else if (n <= 0xFFFF) {
      this._dataBuilder.writeUint8(0xcd);
      this._dataBuilder.writeUint16(n);
    } else if (n <= 0xFFFFFFFF) {
      this._dataBuilder.writeUint8(0xce);
      this._dataBuilder.writeUint32(n);
    } else {
      this._dataBuilder.writeUint8(0xcf);
      this._dataBuilder.writeUint64(n);
    }
  }

  void _writeFloat(Float n) {
    _dataBuilder.writeUint8(0xca);
    _dataBuilder.writeFloat32(n.value);
  }

  void _writeDouble(double n) {
    _dataBuilder.writeUint8(0xcb);
    _dataBuilder.writeFloat64(n);
  }

  void _writeString(String s) {
    final encoded = _codec.encode(s);
    final length = encoded.length;
    if (length <= 31) {
      _dataBuilder.writeUint8(0xA0 | length);
    } else if (length <= 0xFF) {
      _dataBuilder.writeUint8(0xd9);
      _dataBuilder.writeUint8(length);
    } else if (length <= 0xFFFF) {
      _dataBuilder.writeUint8(0xda);
      _dataBuilder.writeUint16(length);
    } else if (length <= 0xFFFFFFFF) {
      _dataBuilder.writeUint8(0xdb);
      _dataBuilder.writeUint32(length);
    } else {
      throw FormatError("String is too long to be serialized with msgpack.");
    }
    _dataBuilder.writeBytes(encoded);
  }

  void _writeBinary(Uint8List buffer) {
    final length = buffer.length;
    if (length <= 0xFF) {
      _dataBuilder.writeUint8(0xc4);
      _dataBuilder.writeUint8(length);
    } else if (length <= 0xFFFF) {
      _dataBuilder.writeUint8(0xc5);
      _dataBuilder.writeUint16(length);
    } else if (length <= 0xFFFFFFFF) {
      _dataBuilder.writeUint8(0xc6);
      _dataBuilder.writeUint32(length);
    } else {
      throw FormatError("Data is too long to be serialized with msgpack.");
    }
    _dataBuilder.writeBytes(buffer);
  }

  void _writeArray(List array) {
    final length = array.length;

    if (length <= 0xF) {
      _dataBuilder.writeUint8(0x90 | length);
    } else if (length <= 0xFFFF) {
      _dataBuilder.writeUint8(0xdc);
      _dataBuilder.writeUint16(length);
    } else if (length <= 0xFFFFFFFF) {
      _dataBuilder.writeUint8(0xdd);
      _dataBuilder.writeUint32(length);
    } else {
      throw FormatError("Array is too big to be serialized with msgpack");
    }

    for (final item in array) {
      encode(item);
    }
  }

  void _writeMap(Map map) {
    final length = map.length;

    if (length <= 0xF) {
      _dataBuilder.writeUint8(0x80 | length);
    } else if (length <= 0xFFFF) {
      _dataBuilder.writeUint8(0xde);
      _dataBuilder.writeUint16(length);
    } else if (length <= 0xFFFFFFFF) {
      _dataBuilder.writeUint8(0xdf);
      _dataBuilder.writeUint32(length);
    } else {
      throw FormatError("Map is too big to be serialized with msgpack");
    }

    for (final item in map.entries) {
      encode(item.key);
      encode(item.value);
    }
  }

  void _writeExt(dynamic object) {
    int type = _extEncoder.extTypeForObject(object);
    if (type != null) {
      if (type < 0) {
        throw FormatError("Negative ext type is reserved");
      }
      final encoded = _extEncoder.encodeObject(object);
      assert(encoded != null);

      final length = encoded.length;
      if (length == 1) {
        _dataBuilder.writeUint8(0xd4);
      } else if (length == 2) {
        _dataBuilder.writeUint8(0xd5);
      } else if (length == 4) {
        _dataBuilder.writeUint8(0xd6);
      } else if (length == 8) {
        _dataBuilder.writeUint8(0xd7);
      } else if (length == 16) {
        _dataBuilder.writeUint8(0xd8);
      } else if (length <= 0xFF) {
        _dataBuilder.writeUint8(0xc7);
        _dataBuilder.writeUint16(length);
      } else if (length <= 0xFFFF) {
        _dataBuilder.writeUint8(0xc8);
        _dataBuilder.writeUint16(length);
      } else if (length <= 0xFFFFFFFF) {
        _dataBuilder.writeUint8(0xc9);
        _dataBuilder.writeUint32(length);
      } else {
        throw FormatError("Size must be at most 0xFFFFFFFF");
      }
      this._dataBuilder.writeUint8(type);
      this._dataBuilder.writeBytes(encoded);
    }
  }

  final _codec = Utf8Codec();
  final ByteDataBuilder _dataBuilder;
  final ExtEncoder _extEncoder;
}
