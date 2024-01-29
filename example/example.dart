import 'dart:io';

import 'package:exif/exif.dart';
import 'package:exif/src/read_exif.dart';
import 'package:xml/xml.dart';
import 'package:xml/xpath.dart';

Future main(List<String> arguments) async {
  for (final filename in arguments) {
    print("read $filename ..");

    final fileBytes = File(filename).readAsBytesSync();
    final data = await readExifFromBytes(fileBytes, strict:false, truncateTags: false, debug: true);

    if (data.isEmpty) {
      print("No EXIF information found");
      return;
    }

    List<String> tagList = getXMPKeywords(data);
    print(tagList.toString());

    for (final entry in data.entries) {
      print("${entry.key}: ${entry.value}");
    }


  }
}
