import 'dart:typed_data';
import 'package:aharconnect/controller/auth_controller.dart';
import 'package:aharconnect/controller/create_post_controller.dart';
import 'package:aharconnect/controller/zone_controller.dart';
import 'package:aharconnect/data/model/zone_model.dart';
import 'package:aharconnect/view/screen/bottom%20nav%20bar/bottom_nav.dart';
import 'package:aharconnect/view/widget/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:aharconnect/utils/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:aharconnect/utils/theme_colors.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';

class CreateRecipePostScreen extends StatefulWidget {
  CreateRecipePostScreen({required this.isFeed, Key? key}) : super(key: key);
  bool isFeed;

  @override
  State<CreateRecipePostScreen> createState() => _CreateRecipePostScreenState();
}

class _CreateRecipePostScreenState extends State<CreateRecipePostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? servesValue;

  final List<TextEditingController> _ingredientControllersList = [];
  final List<TextEditingController> _instructionsControllersList = [];
  bool _isLoading = false;
  Uint8List? _imageFile;
  List<ZoneModel>? _zoneList;
  List _selecteZone = [];
  PlatformFile? file;
  XFile? pdfFile;
  final ScrollController _firstController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<ZoneController>().getZoneList(false);
  }

  void _selectAnImageDialog(BuildContext context) async {
    () => FocusManager.instance.primaryFocus?.unfocus();
    // final settingsManager =
    // Provider.of<SettingsProvider>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        // final imageProvider =
        //     Provider.of<UserImageProvider>(context, listen: false);
        return SimpleDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(15, 10))),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'select_an_image'.tr,
              style: GoogleFonts.openSans(
                  fontSize: 18, color: ThemeColors.blackColor),
            ),
          ),
          children: [
            // SimpleDialogOption(
            //     child: Text(
            //       'take_a_photo'.tr,
            //       style: GoogleFonts.openSans(
            //         color: ThemeColors.blackColor,
            //       ),
            //     ),
            //     onPressed: () async {
            //       Navigator.pop(context);
            //       await Get.find<CreatePostController>().pickCameraImage();
            //       setState(() {
            //         _imageFile = Get.find<CreatePostController>().rawFile;
            //       });
            //     }),
            SimpleDialogOption(
                child: Text(
                  'choose_from_gallery'.tr,
                  style: GoogleFonts.openSans(
                    color: ThemeColors.blackColor,
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await Get.find<CreatePostController>().pickGalleryImage();
                  setState(() {
                    _imageFile = Get.find<CreatePostController>().rawFile;
                  });
                }),
            Padding(
              padding: const EdgeInsets.all(20).copyWith(bottom: 0),
              child: SimpleDialogOption(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Cancel',
                      style: GoogleFonts.openSans(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _cookTimeController.dispose();
    for (TextEditingController t in _ingredientControllersList) {
      t.dispose();
    }
    for (TextEditingController t in _instructionsControllersList) {
      t.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Theme(
        data: Theme.of(context).copyWith(
          useMaterial3: true,
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Material(
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        if (widget.isFeed) {
                          if (_imageFile == null ||
                              _descriptionController.text == "") {
                            showCustomSnackBar(
                                "please_add_image_or_description".tr,
                                isError: true);
                          } else if (_selecteZone.isEmpty) {
                            showCustomSnackBar("please_select_zone".tr,
                                isError: true);
                          } else {
                            Get.find<CreatePostController>().uploadPost(
                                Get.find<AuthController>()
                                    .getUserId()
                                    .toString(),
                                _descriptionController.text,
                                _selecteZone,
                                "Post",
                                "Image");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar(
                                          index: 0,
                                        )));
                          }
                        } else {
                          if (pdfFile == null ||
                              _descriptionController.text == "") {
                            showCustomSnackBar(
                                "please_add_pdf_or_description".tr,
                                isError: true);
                          } else if (_selecteZone.isEmpty) {
                            showCustomSnackBar("please_select_zone".tr,
                                isError: true);
                          } else {
                            Get.find<CreatePostController>().uploadPost(
                                Get.find<AuthController>()
                                    .getUserId()
                                    .toString(),
                                _descriptionController.text,
                                _selecteZone,
                                "Noticboard",
                                "PDF");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar(
                                          index: 0,
                                        )));
                          }
                        }
                      },
                      child: Ink(
                        width: 95,
                        decoration: const BoxDecoration(
                            color: ThemeColors.buttonColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            )),
                        child: Center(
                          child: Text(
                            'post'.tr,
                            style: GoogleFonts.openSans(
                                fontSize: 19,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///Upload Image
                    widget.isFeed
                        ? Material(
                            child: InkWell(
                              highlightColor: Colors.grey.shade400,
                              onTap: () {
                                _selectAnImageDialog(context);
                              },
                              child: Ink(
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  color: ThemeColors.uploadImageBagroundColor,
                                  gradient: const LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromARGB(255, 55, 246, 246),
                                      Color.fromARGB(255, 13, 94, 91),
                                    ],
                                  ),
                                  image: _imageFile == null
                                      ? null
                                      : DecorationImage(
                                          image: MemoryImage(_imageFile!),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 80,
                                      left: 0,
                                      right: 0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            'upload_your_image'.tr,
                                            style: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: const Color.fromARGB(
                                                  255, 253, 253, 253),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),

                    ///Description field
                    TextFormField(
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Description Required';
                        }
                        return null;
                      },
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      style: GoogleFonts.openSans(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          height: 1.6),
                      controller: _descriptionController,
                      maxLines: 4,
                      cursorHeight: 30,
                      autofocus: false,
                      autocorrect: false,
                      keyboardType: TextInputType.multiline,
                      obscureText: false,
                      decoration: InputDecoration(
                        counterText: ' ',
                        fillColor: Colors.white,
                        filled: true,
                        isCollapsed: false,
                        contentPadding: const EdgeInsets.all(18),
                        hintText: "whats_happening".tr,
                        hintStyle: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                            height: 1.6),
                        focusedErrorBorder: kFocusedErrorBorder,
                        errorBorder: kErrorBorder,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ThemeColors.greyTextColor, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ThemeColors.greyTextColor, width: 1),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),

                    // TextField(
                    //   controller: _descriptionController,
                    // ),

                    ///Add PDF Field
                    widget.isFeed
                        ? const SizedBox()
                        : InkWell(
                            highlightColor: Colors.grey.shade400,
                            onTap: () async {
                              await Get.find<CreatePostController>().pickPDF(context);
                              setState(() {
                                // file = PlatformFile( name: '${Get.find<CreatePostController>().pickedFile.path}', size: 1);
                                // print(file!.path);
                                pdfFile =
                                    Get.find<CreatePostController>().pickedFile;
                                print(pdfFile);
                              });
                            },
                            child: Ink(
                              height: MediaQuery.of(context).size.height / 5.8,
                              decoration: const BoxDecoration(
                                color: ThemeColors.uploadImageBagroundColor,
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Color.fromARGB(255, 55, 246, 246),
                                    Color.fromARGB(255, 13, 94, 91),
                                  ],
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 20,
                                    left: 0,
                                    right: 0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform.rotate(
                                          angle: 160 * math.pi / 90,
                                          child: const Icon(
                                            Icons.attachment_outlined,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'add_media'.tr,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: const Color.fromARGB(
                                                255, 253, 253, 253),
                                          ),
                                        ),
                                        Text(
                                          'only_pdf'.tr,
                                          style: GoogleFonts.openSans(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: const Color.fromARGB(
                                                255, 253, 253, 253),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                    pdfFile != null
                        ? const SizedBox(height: 5.0,) : const SizedBox(),


                    ///Selected PDF Name
                    pdfFile != null
                        ? Text(pdfFile!.name.toString())
                        : const SizedBox(),

                    const SizedBox(
                      height: 10.0,
                    ),

                    ///Zone List
                    GetBuilder<ZoneController>(builder: (zoneController) {
                      _zoneList = zoneController.zoneList;
                      return _zoneList != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.isFeed
                                    ? const SizedBox()
                                    : const SizedBox(
                                        height: 20.0,
                                      ),
                                Text(
                                  "${"visible".tr}:",
                                  style: GoogleFonts.openSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.8,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: ThemeColors.greyTextColor
                                            .withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: ListView.builder(
                                      itemCount: _zoneList!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          value: _selecteZone.contains(
                                              _zoneList![index].zoneId),
                                          onChanged: (bool? selected) {
                                            // setState(() {
                                            //   if(_zoneList![index].id == 0){
                                            //     // for (var element in _zoneList!) {
                                            //     _selecteZone.clear();
                                            //     for(int i = 0 ; i<_zoneList!.length ; i++) {
                                            //       if (_zoneList![i].isSelected == false) {
                                            //               _zoneList![i].isSelected = true;
                                            //               _selecteZone.add(_zoneList![i].id);
                                            //             } else {
                                            //               _zoneList![i].isSelected = false;
                                            //               _selecteZone.remove(_zoneList![i].id);
                                            //             }
                                            //           }
                                            //   }
                                            // });
                                            // _zoneList![index].isSelected = selected;
                                            _onCategorySelected(selected!,
                                                _zoneList![index].zoneId);
                                          },
                                          title: Text(_zoneList![index]
                                              .zoneName
                                              .toString()),
                                        );
                                      }),
                                ),
                              ],
                            )
                          : const SizedBox();
                    }),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _isLoading == true
                    ? LinearProgressIndicator(
                        backgroundColor: Colors.grey.shade300,
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 4),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCategorySelected(bool selected, category_id) {
    if (selected == true) {
      setState(() {
        _selecteZone.add(category_id);
      });
    } else {
      setState(() {
        _selecteZone.remove(category_id);
      });
    }
    // print(_selecteZone);
  }
}
