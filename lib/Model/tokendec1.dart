import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

Map<String, dynamic> parseJwt(String token, String secretKey) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final header = _decodeBase64(parts[0]);
  final payload = _decodeBase64(parts[1]);
  final signature = _decodeBase64(parts[2]);

  final verified = _verifySignature(header, payload, signature, secretKey);
  if (!verified) {
    throw Exception('Invalid signature');
  }

  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('Invalid payload');
  }

  return payloadMap;
}

bool _verifySignature(
    String header, String payload, String signature, String secretKey) {
  final verifiedData = utf8.encode('$header.$payload');
  final hmac = Hmac(
      sha256,
      utf8.encode(
          secretKey)); // Create an HMAC-SHA256 object with your secret key.
  final calculatedSignature = hmac.convert(verifiedData).bytes;
  final expectedSignature = base64Url.decode(signature);

  return Uint8List.fromList(calculatedSignature).toList() == expectedSignature;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!');
  }

  return utf8.decode(base64Url.decode(output));
}
