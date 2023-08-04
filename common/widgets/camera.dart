import 'dart:io';

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CameraPage {
  Future<dynamic> bottomSheetImage(
      BuildContext context, XFile? fileImage) async {
    showModalBottomSheet(
        useSafeArea: true,
        constraints: const BoxConstraints(maxHeight: 100.0),
        context: context,
        builder: (c) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Select the type"),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(c);
                        },
                        icon: const Icon(Icons.close)),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 20.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: InkWell(
                       onTap: () async {
                          final response =
                              await addImageCameraWidget(fileImage);
                          if (response != null) {
                            fileImage = response;
                          }

                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Color.fromARGB(255, 24, 97, 156),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: InkWell(
                        onTap: () async {
                          final response =
                              await addImageGalleryWidget(fileImage);
                          if (response != null) {
                            fileImage = response;
                          }

                          if (context.mounted) Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.photo,
                          color: Color.fromARGB(255, 24, 97, 156),
                        )),
                  ),
                  // Container(
                  //   width: 40,
                  //   height: 40,
                  //   margin: const EdgeInsets.only(left: 20.0),
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(
                  //         color: Colors.grey,
                  //       )),
                  //   child: InkWell(
                  //       onTap: () {
                  //         addDocumentWidget();
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: const Icon(
                  //         Icons.document_scanner,
                  //         color: Color.fromARGB(255, 24, 97, 156),
                  //       )),
                  // )
                ],
              )
            ],
          );
        });
    return fileImage ?? XFile("");
  }

  Future<dynamic> addImageCameraWidget(XFile? fileImage) async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    Directory dir = await getApplicationDocumentsDirectory();

    if (file != null) {
      final fileName = path.basename(file.path);
      await file.saveTo("${dir.path}/$fileName");
      fileImage = XFile(file.path);
      debugPrint(" file image is ${dir.path}/$fileName}");
      await SharedStorage.setString("trade_logo", fileImage.path);
      return fileImage;
    }
    // if (mounted) {
    //   setState(() {});
    // }
  }

  Future<dynamic> addImageGalleryWidget(XFile? fileImage) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    Directory dir = await getApplicationDocumentsDirectory();

    if (file != null) {
      // final fileName = path.basename(file.path);
      // await file.saveTo("${dir.path}/$fileName");
      fileImage = XFile(file.path);
      debugPrint(" file image is ${dir.path}}");
      await SharedStorage.setString("trade_logo", fileImage.path);
      return fileImage;
    }
    // if (mounted) {
    //   setState(() {});
    // }
  }
}
