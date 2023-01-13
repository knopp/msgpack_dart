part of msgpack_dart;

class FormatError implements Exception {
  FormatError(this.message);
  final String message;

  String toString() {
    return "FormatError: $message";
  }
}

/// The upstream stream closed unexpectedly while in the midst of decoding a message.
/// Thrown from [StreamDeserializer]
class UpstreamClosedError implements Exception {
  const UpstreamClosedError();
  final String message = 'Upstream closed unexpectedly';

  String toString() {
    return "UpstreamClosedError: $message";
  }
}
