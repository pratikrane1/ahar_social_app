import 'dart:async';
import 'dart:io';

import 'package:aharconnect/controller/home_controller.dart';
import 'package:aharconnect/screen/home/widget/pdf_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:aharconnect/widget/app_button.dart';
import 'package:path_provider/path_provider.dart';
class DocumentFile extends StatefulWidget {
  const DocumentFile({super.key});

  @override
  State<DocumentFile> createState() => _DocumentFileState();
}

class _DocumentFileState extends State<DocumentFile> {
  String remotePDFpath = "";

    Future<File> createFileOfPdfUrl(String url) async {
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getTemporaryDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    String? pdfFile;

    return Padding(
      padding:
      const EdgeInsets.only(left: 10.0, right: 10.0, top: 20, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.primaryColor,
              blurRadius: 3,
              spreadRadius: 0.3,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "presentation".tr,
                  style: TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              AppButton(
                onPressed: () async {
                  String url = await Get.find<HomeController>().getPdfUrl();

                  await createFileOfPdfUrl(url).then((f) {
                    setState(() {
                      remotePDFpath = f.path;
                    });
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFVIEW(pdfLocalPath: remotePDFpath,pdfURL: "http://www.pdf995.com/samples/pdf.pdf",)));
                },
                height: 34,
                width: 80,
                text: Text(
                  'open'.tr,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.fontSizeDefault,
                      fontFamily: 'Montserrat-Bold',
                      fontWeight: FontWeight.w700),
                ),
                loading: true,
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(
                      color: ThemeColors.buttonColor, width: 1),
                  backgroundColor: ThemeColors.buttonColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
