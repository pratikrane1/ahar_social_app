import 'dart:io';

import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future downloadPDF(String url) async {
  var fileName = url.split(Platform.pathSeparator).last;
  await Permission.storage.request();
  try {
    Directory? directory;
    directory = await getExternalStorageDirectory();
    String newPath = "";
    List<String> paths = directory!.path.split("/");
    for (int x = 1; x < paths.length; x++) {
      String folder = paths[x];
      if (folder != "Android") {
        newPath += "/" + folder;
      } else {
        break;
      }
    }
    newPath = newPath + "/Download";
    directory = Directory(newPath);

    File saveFile = File(directory.path + "/$fileName");
    if (kDebugMode) {
      print(saveFile.path);
    }
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    if (await directory.exists()) {
      await Dio().download(
        url,
        saveFile.path,
      );
      showCustomSnackBar("pdf_downloaded_in_downloaded_folder".tr, isError: false);
    }
  } catch (e) {
    showCustomSnackBar("Failed to download.".tr, isError: false);
    return print(e);
  }
}
