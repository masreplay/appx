import 'dart:io';

import 'package:appx/client/client.dart';
import 'package:dio/dio.dart';

class XFileMultipartConvertor implements JsonConverter<XFile, MultipartFile> {
  const XFileMultipartConvertor();

  // ignored
  @override
  XFile fromJson(MultipartFile json) {
    return XFile(json.filename ?? "");
  }

  @override
  MultipartFile toJson(XFile object) {
    return MultipartFile.fromFileSync(
      object.path,
      filename: object.path.split(Platform.pathSeparator).last,
    );
  }
}
