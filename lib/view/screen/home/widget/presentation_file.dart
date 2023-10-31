import 'package:aharconnect/controller/home_controller.dart';
import 'package:aharconnect/view/screen/home/widget/pdf_view.dart';
import 'package:aharconnect/view/widget/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:aharconnect/utils/dimensions.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DocumentFile extends StatefulWidget {
  const DocumentFile({super.key});

  @override
  State<DocumentFile> createState() => _DocumentFileState();
}

class _DocumentFileState extends State<DocumentFile> {
  String remotePDFpath = "";


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
                  style: GoogleFonts.openSans(
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AppButton(
                onPressed: () async {
                  String url = await Get.find<HomeController>().getPdfUrl();
                  await Get.find<HomeController>().createFileOfPdfUrl(url).then((f) {
                    setState(() {
                      remotePDFpath = f.path;
                    });
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PDFVIEW(pdfLocalPath: remotePDFpath,pdfURL: url,)));
                },
                height: 34,
                width: 80,
                text: Text(
                  'open'.tr,
                  style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontSize: Dimensions.fontSizeDefault,
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
