import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:socialrecipe/utils/dimensions.dart';
import 'package:socialrecipe/utils/theme_colors.dart';
import 'package:socialrecipe/widget/app_button.dart';


class DocumentFile extends StatelessWidget {
  DocumentFile();

  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    String? pdfFile;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 20,bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius:
          BorderRadius.circular(Dimensions.RADIUS_SMALL),
          boxShadow: const [
            BoxShadow(
              color: ThemeColors.primaryColor,
              blurRadius: 3,
              spreadRadius: 0.3,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 10.0,bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "Presentation".tr,
                  style: TextStyle(
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              AppButton(
                onPressed: () async {
                  // String url = "";
                  String url = "http://ahar.ezii.live/public/assets/pdf/New-Doc-12-22-2022-18.22-1.pdf";
                  var config = Config();
                  // How to disable functionality:
                  config.disabledElements = [ Buttons.searchButton];
                  config.disabledTools = [Tools.annotationCreateLine, Tools.annotationCreateRectangle];
                  // Other viewer configurations:
                  config.hideAnnotationToolbarSwitcher = true;
                  config.showLeadingNavButton = true;
                  // config.hideBottomToolbar = true;
                  config.multiTabEnabled = true;
                  config.downloadDialogEnabled = false;
                  config.readOnly=true;
                  config.bottomToolbar=[Buttons.shareButton,Buttons.saveCopyButton];
                  config.customHeaders = {'headerName': 'headerValue'};

                  await PdftronFlutter.openDocument(url,config: config);
                },
                height: 34,
                width: 80,
                text: Text(
                  'Open',
                  style:  TextStyle(
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
