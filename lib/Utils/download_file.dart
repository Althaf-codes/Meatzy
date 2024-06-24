import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class Utils {
  static Future<String> downloadFile(String url, String filename) async {
    final directory = await getApplicationDocumentsDirectory();

    final filePath = '${directory.path}/$filename';

    final file = File(filePath);

    final response = await http.get(Uri.parse(url));
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  void deletefile(String filename) {
    final file = File('Big_Picture');
    file.delete();
  }
}
