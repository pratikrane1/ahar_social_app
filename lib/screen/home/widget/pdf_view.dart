import 'package:aharconnect/helper/download_file.dart';
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class PDFVIEW extends StatefulWidget {
  PDFVIEW({required this.pdfLocalPath,required this.pdfURL,super.key});
  String pdfLocalPath;
  String pdfURL;

  @override
  State<PDFVIEW> createState() => _PDFVIEWState();
}

class _PDFVIEWState extends State<PDFVIEW> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.whiteColor,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24,
          ),
        ),
        centerTitle: false,
        elevation: 4.0,
        bottomOpacity: 0.0,
        title: Text(
          'pdf'.tr,
          style: GoogleFonts.openSans(
            fontSize: 25,
            color: ThemeColors.blackColor,
          ),
        ),
        actions:  [

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: InkWell(
              onTap: ()async{
                await downloadPDF(widget.pdfURL);
              },
              child: const FaIcon(FontAwesomeIcons.download,
                size: 23,
                color: ThemeColors.blackColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0,right: 15.0,left: 12.0),
            child: InkWell(
              onTap: ()async{
                await Share.share(widget.pdfURL);
              },
              child: const FaIcon(FontAwesomeIcons.share,
                size: 23,
                color: ThemeColors.blackColor,
              ),
            ),
          )
        ],
      ),
      body: PDFView(
        filePath: widget.pdfLocalPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
        onRender: (_pages) {
          // setState(() {
          //   pages = _pages;
          //   isReady = true;
          // });
        },
        onError: (error) {
          print(error.toString());
        },
        onPageError: (page, error) {
          print('$page: ${error.toString()}');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          // _controller.complete(pdfViewController);
        },
        onPageChanged: (int? page, int? total) {
          print('page change: $page/$total');
        },
      ),
    );
  }
}

