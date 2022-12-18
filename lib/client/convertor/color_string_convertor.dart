import 'package:appx/client/client.dart';
import 'package:flutter/material.dart';

class HexColorConvertor extends JsonConverter<Color, String> {
  final bool leadingHashSign;

  const HexColorConvertor({this.leadingHashSign = true});

  @override
  Color fromJson(String json) {
    final buffer = StringBuffer();
    if (json.length == 6 || json.length == 7) buffer.write('ff');
    buffer.write(json.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  String toJson(Color object) {
    return '${leadingHashSign ? '#' : ''}'
        '${object.alpha.toRadixString(16).padLeft(2, '0')}'
        '${object.red.toRadixString(16).padLeft(2, '0')}'
        '${object.green.toRadixString(16).padLeft(2, '0')}'
        '${object.blue.toRadixString(16).padLeft(2, '0')}';
  }
}
