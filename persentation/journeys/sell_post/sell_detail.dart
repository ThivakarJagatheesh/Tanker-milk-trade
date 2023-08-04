import 'dart:io';

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/data/models/product_model.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/product/product_bloc.dart';
import 'package:dairy_products/persentation/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SellPostDetailPage extends StatefulWidget {
  const SellPostDetailPage({super.key});

  @override
  State<SellPostDetailPage> createState() => _SellPostDetailPageState();
}

class _SellPostDetailPageState extends State<SellPostDetailPage> {
  String category = "";
  String categoryType = " ";
  String productType = '';
  String milkType = "";
  String requirementType = "One-time";
  List<String> categoryList = [];
  List<String> categoryTypeList = [];
  List<ProductBody> categorys = [];
  List<ProductBody> categoryTypes = [];
  // var categoryTypes = ["Whole Milk", "Skimmed Milk", "Raw-Chilled-Milk"];
  var requirementTypes = [
    "One-time",
    "Weekly",
    "Two days",
    "Three days",
    "Four days",
    "Five days",
    "Six days",
    "Seven days"
  ];
  List<String> image = [
    "assests/milk-cream.jpg",
    "assests/milk-powder.jpg",
    "assests/whole-milk.jpg"
  ];
  var qtyController = TextEditingController();
  var categoryController = TextEditingController();
  var productController = TextEditingController();
  var availableController = TextEditingController();
  var chooseFileController = TextEditingController();
  var expectingPriceController = TextEditingController();
  var fatController = TextEditingController();
  var snfController = TextEditingController();
  var mbrtController = TextEditingController();
  var clrController = TextEditingController();
  var ageOfMilkController = TextEditingController();
  var expiryDateController = TextEditingController();
  late ProductBloc productBloc;
  File? fileImage;
  String? categoryImage = "assests/milk-cream.jpg";
  XFile? fileDocument;
  @override
  void initState() {
    productBloc = getItInstance<ProductBloc>();
    Future.microtask(() {
      getProduct();
      //getSubProduct();
    });
    super.initState();
  }

  getProduct() {
    productBloc.getProductType(1);
  }

  getSubProduct(int? id) {
    productBloc.getSubProductType(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        centerTitle: true,
        title: Text(
          "To Sell Post",
          style: CommonStyles(context).appBarStyle(),
        ),
      ),
      body: BlocProvider.value(
        value: productBloc,
        child:
            BlocConsumer<ProductBloc, ProductState>(listener: (context, state) {
          if (state is ProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "success",
              style: CommonStyles(context).style(color: Colors.white),
            )));
          }
          if (state is ProductFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.errorMessage,
              style: CommonStyles(context).style(color: Colors.white),
            )));
          }
          if (state is ProductTypeState) {
            categorys = state.productModel.body!;
            for (var res in categorys) {
              categoryList.add(res.productTypeName!);
            }
            category = state.productModel.body!.first.productTypeName!;
            productType = state.productModel.body!.first.productTypeId!;
          }
          if (state is SubProductTypeState) {
            categoryTypes = state.productModel.body!;
            for (var res in categoryTypes) {
              categoryTypeList.add(res.productTypeName!);
            }
            categoryType = state.productModel.body!.first.productTypeName!;
            milkType = state.productModel.body!.first.productTypeId!;
            setState(() {});
          }
        }, builder: (context, snapshot) {
          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 10,
              ),
              // textWidget("Category"),
              // Container(
              //   width: double.infinity,
              //   height: 55,
              //   // width: 250,
              //   margin: const EdgeInsets.only(
              //       left: 10.0, right: 10, top: 5.0, bottom: 10.0),
              //   decoration: BoxDecoration(
              //       // color: Colors.white,
              //       border: Border.all(
              //         color: Colors.grey,
              //         // width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: DropdownButtonHideUnderline(
              //     child: ButtonTheme(
              //       alignedDropdown: true,
              //       child: DropdownButton<String>(
              //         value: category,
              //         isDense: false,
              //         hint: const Text("Please select Type"),
              //         items: categorys.map((ProductBody value) {
              //           return DropdownMenuItem<String>(
              //             value: value.productTypeName,
              //             child: Text(
              //               value.productTypeName!,
              //               style: CommonStyles(context).textFormFieldStyle(),
              //             ),
              //           );
              //         }).toList(),
              //         onChanged: (String? newValue) async {
              //           for (var productTypeValue in categorys) {
              //             if (productTypeValue.productTypeName == newValue) {
              //               productType = productTypeValue.productTypeId!;
              //               debugPrint("productId is $productType");
              //               categoryTypes = [];
              //               categoryType = "";
              //               getSubProduct(int.parse(productType));
              //             }
              //           }
              //           setState(() {
              //             category = newValue!;
              //             if (newValue == "Milk") {
              //               categoryImage = image[0];
              //             } else if (newValue == "Cream") {
              //               categoryImage = image[1];
              //             } else if (newValue == "Butter") {
              //               categoryImage = image[2];
              //             }
              //           });
              //           final documentPath =
              //               await getApplicationDocumentsDirectory();
              //           fileImage =
              //               await File('${documentPath.path}/$categoryImage')
              //                   .create(recursive: true);
              //           debugPrint(fileImage!.path);
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // textWidget("Category Type"),
              // Container(
              //   width: double.infinity,
              //   height: 55,
              //   // width: 250,
              //   margin: const EdgeInsets.only(
              //       left: 10.0, right: 10, top: 5.0, bottom: 5.0),
              //   decoration: BoxDecoration(
              //       // color: Colors.white,
              //       border: Border.all(
              //         color: Colors.grey,
              //         // width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: DropdownButtonHideUnderline(
              //     child: ButtonTheme(
              //       alignedDropdown: true,
              //       child: DropdownButton<String>(
              //         value: categoryType,
              //         isDense: false,
              //         hint: const Text("Please select Type"),
              //         items: categoryTypes.map((ProductBody value) {
              //           return DropdownMenuItem<String>(
              //             value: value.productTypeName,
              //             child: Text(
              //               value.productTypeName ?? '',
              //               style: CommonStyles(context).textFormFieldStyle(),
              //             ),
              //           );
              //         }).toList(),
              //         onChanged: (String? newValue) {
              //           for (var productTypeValue in categoryTypes) {
              //             if (productTypeValue.productTypeName == newValue) {
              //               milkType = productTypeValue.productTypeId!;
              //             }
              //           }
              //           setState(() {
              //             categoryType = newValue!;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              TextFormFieldWidgets(
                labelText: 'Category',
                hintText: 'Select the category',
                controller: categoryController,
                keyboardType: TextInputType.text,
                horizontal: 10,
                vertical: 5,
                onTap: () {
                  dropDownRadio(categoryList, categoryType, (newValue) async {
                    for (var productTypeValue in categorys) {
                      if (productTypeValue.productTypeName == newValue) {
                        productType = productTypeValue.productTypeId!;
                        debugPrint("productId is $productType");
                        categoryTypes = [];
                        categoryType = "";
                        categoryTypeList = [];
                        productController.clear();
                        getSubProduct(int.parse(productType));
                      }
                    }

                    category = newValue!;
                    if (newValue == "Milk") {
                      categoryImage = image[0];
                    } else if (newValue == "Cream") {
                      categoryImage = image[1];
                    } else if (newValue == "Butter") {
                      categoryImage = image[2];
                    }

                    final documentPath =
                        await getApplicationDocumentsDirectory();
                    fileImage =
                        await File('${documentPath.path}/$categoryImage')
                            .create(recursive: true);
                    debugPrint(fileImage!.path);
                    setState(() {
                      categoryType = newValue.toString();
                      categoryController.text = newValue.toString();
                    });
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  });
                },
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ),
              TextFormFieldWidgets(
                labelText: 'Product',
                hintText: 'Select the product',
                horizontal: 10,
                vertical: 5,
                controller: productController,
                keyboardType: TextInputType.text,
                enabled: categoryTypeList.isNotEmpty ? true : false,
                onTap: () {
                  dropDownRadio(categoryTypeList, categoryType, (newValue) {
                    setState(() {
                      categoryType = newValue.toString();
                      productController.text = newValue.toString();
                    });
                    Navigator.pop(context);
                  });
                },
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ),
              TextFormFieldWidgets(
                horizontal: 10,
                vertical: 5,
                labelText: "qty",
                controller: qtyController,
                hintText: "In litres (12)",
              ),
              const SizedBox(
                height: 5,
              ),
              // textWidget("Available Type"),
              // Container(
              //   width: double.infinity,
              //   height: 55,
              //   // width: 250,
              //   margin: const EdgeInsets.only(
              //       left: 10.0, right: 10, top: 5.0, bottom: 10.0),
              //   decoration: BoxDecoration(
              //       // color: Colors.white,
              //       border: Border.all(
              //         color: Colors.grey,
              //         // width: 1,
              //       ),
              //       borderRadius: BorderRadius.circular(6)),
              //   child: DropdownButtonHideUnderline(
              //     child: ButtonTheme(
              //       alignedDropdown: true,
              //       child: DropdownButton<String>(
              //         value: requirementType,
              //         isDense: false,
              //         hint: const Text("Please select Type"),
              //         items: requirementTypes.map((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: Text(
              //               value,
              //               style: CommonStyles(context).textFormFieldStyle(),
              //             ),
              //           );
              //         }).toList(),
              //         onChanged: (String? newValue) {
              //           setState(() {
              //             requirementType = newValue!;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              TextFormFieldWidgets(
                labelText: 'Available',
                hintText: 'Select the availale',
                horizontal: 10,
                vertical: 5,
                controller: availableController,
                keyboardType: TextInputType.text,
                enabled: requirementTypes.isNotEmpty ? true : false,
                onTap: () {
                  dropDownRadio(requirementTypes, requirementType, (newValue) {
                    setState(() {
                      requirementType = newValue.toString();
                      availableController.text = newValue.toString();
                    });
                    Navigator.pop(context);
                  });
                },
                suffixIcon: const Icon(
                  Icons.arrow_drop_down,
                  size: 30,
                ),
              ),
              TextFormFieldWidgets(
                  horizontal: 10,
                  vertical: 10,
                  controller: expiryDateController,
                  hintText: "Post Valid Till",
                  labelText: "Post valid till",
                  suffixIcon: InkWell(
                    child: const Icon(
                      Icons.calendar_month,
                      color: Color.fromARGB(255, 24, 97, 156),
                    ),
                    onTap: () async {
                      //  DatePickerDialog(initialDate: DateTime.now(),firstDate: DateTime(1950),lastDate: DateTime.now(),).currentDate;
                      final selectDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(3000));

                      if (selectDate != null) {
                        expiryDateController.text = DateFormat("dd/MM/yyyy")
                            .format(DateUtils.dateOnly(selectDate));
                      }
                    },
                  )),
              // textWidget("Available QTY"),

              const SizedBox(
                height: 5,
              ),
              //textWidget("Expecting Price"),
              TextFormFieldWidgets(
                horizontal: 10,
                vertical: 5,
                labelText: "Expecting doc price",
                controller: expectingPriceController,
                hintText: "In Rupees",
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // textWidget(" FAT"),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormFieldWidgets(
                                vertical: 5.0,
                                horizontal: 10,
                                labelText: "FAT",
                                controller: fatController,
                                hintText: "Max:6.99")),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // textWidget(" SNF"),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormFieldWidgets(
                                vertical: 5.0,
                                horizontal: 10,
                                labelText: "SNF",
                                controller: snfController,
                                hintText: "Max:8.99")),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // textWidget(" MBRT"),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormFieldWidgets(
                                vertical: 5.0,
                                horizontal: 10.0,
                                labelText: "MBRT",
                                controller: mbrtController,
                                hintText: "In Hours")),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // textWidget(" CLR"),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextFormFieldWidgets(
                                vertical: 5.0,
                                horizontal: 10,
                                labelText: "CLR",
                                controller: clrController,
                                hintText: "In Digits")),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              //textWidget("Age Of Milk"),
              TextFormFieldWidgets(
                horizontal: 10,
                vertical: 5,
                controller: ageOfMilkController,
                hintText: "In Days",
                labelText: "Age of milk",
              ),
              const SizedBox(
                height: 5,
              ),
              textWidget("Category Image"),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width - 20,
                margin: const EdgeInsets.only(left: 10.0, top: 0, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    bottomSheetImage();
                    //  Navigator.pop(context);
                  },
                  child: categoryImage != null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Image.asset(
                            categoryImage!,
                            fit: BoxFit.contain,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image,
                              color: Color.fromARGB(255, 24, 97, 156),
                              size: 80,
                            ),
                            Text(
                              "",
                              style: CommonStyles(context)
                                  .style(color: Colors.grey),
                            )
                          ],
                        ),
                )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget("Product Report"),
                  fileDocument != null
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              // fileImage = null;
                              fileDocument = null;
                            });
                          },
                          icon: const Icon(Icons.close, color: Colors.red))
                      : const Column(),
                ],
              ),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width - 20,
                margin: const EdgeInsets.only(left: 10.0, top: 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey)),
                child: Center(
                    child: InkWell(
                  onTap: () {
                    bottomSheetImage();
                    //  Navigator.pop(context);
                  },
                  child: fileDocument != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.file_copy,
                              color: Colors.grey,
                              size: 60,
                            ),
                            Text(fileDocument!.path.split('/').last),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image,
                              color: Color.fromARGB(255, 24, 97, 156),
                              size: 80,
                            ),
                            Text(
                              "Support format pdf....",
                              style: CommonStyles(context)
                                  .style(color: Colors.grey),
                            )
                          ],
                        ),
                )),
              ),
              Container(
                height: 50,
                width: 250,

                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 2 - 120,
                    bottom: 10.0,
                    top: 10.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 24, 97, 156),
                    borderRadius: BorderRadius.circular(20)),
                // margin: const EdgeInsets.all(20),

                child: MaterialButton(
                  onPressed: () {
                    submitShell();
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       // Retrieve the text the that user has entered by using the
                    //       // TextEditingController.
                    //       content: Text("TEST"),
                    //     );
                    //   },
                    // );
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(builder: (_) => const POSTLIST()),
                    //     (route) => false);
                  },
                  child: Text(
                    'Submit',
                    style:
                        CommonStyles(context).buttonStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
          );
        }),
      ),
    );
  }

  Widget textWidget(String data) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      child: Text(
        data,
        style: CommonStyles(context).style(color: Colors.grey.withOpacity(1.0)),
      ),
    );
  }

  submitShell() {
    if (categoryImage != null && fileDocument != null) {
      ShellBuyBody shellBuyBody = ShellBuyBody()
        ..userId = SharedStorage.getString(ApiConfig.userId)
        ..ageOfMilk = ageOfMilkController.text
        ..avaiablequanitity = qtyController.text
        ..email = "tanker@gamil.com"
        ..fat = fatController.text
        ..labreportFile = fileDocument!.path
        ..prductImage = fileImage!.path
        ..mbrt = mbrtController.text
        ..postType = "SELL"
        ..price = expectingPriceController.text
        ..milkType = milkType
        ..productType = productType
        ..productName = category
        ..subProducttypeName = productController.text
        ..productTypeName = requirementType
        ..snf = snfController.text
        ..mobile = "1234567890"
        ..postCreatedDateTime = DateTime.now()
        ..postExpiredDateTime = DateTime.now();

      productBloc.addProduct(shellBuyBody);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("please select the image")));
    }
  }

  addImageCameraWidget() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file != null) {
      fileImage = File(file.path);
    }
    if (mounted) {
      setState(() {});
    }
  }

  addImageGalleryWidget() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      fileImage = File(file.path);
    }
    if (mounted) {
      setState(() {});
    }
  }

  addDocumentWidget() async {
    final utiController = TextEditingController(
      text: 'com.sidlatau.example.mwfbak',
    );

    final extensionController = TextEditingController(
      text: 'mwfbak',
    );

    final mimeTypeController = TextEditingController(
      text: 'application/pdf',
    );
    FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
      allowedFileExtensions: Platform.isIOS
          ? extensionController.text
              .split(' ')
              .where((x) => x.isNotEmpty)
              .toList()
          : null,
      allowedUtiTypes: Platform.isIOS
          ? null
          : utiController.text.split(' ').where((x) => x.isNotEmpty).toList(),
      allowedMimeTypes: Platform.isAndroid
          ? mimeTypeController.text
              .split(' ')
              .where((x) => x.isNotEmpty)
              .toList()
          : null,
    );

    final path = await FlutterDocumentPicker.openDocument(params: params);
    debugPrint("path is $path");
    if (path != null) {
      //fileImage = null;

      fileDocument = XFile(path);
    }
    if (mounted) {
      setState(() {});
    }
  }

  bottomSheetImage() {
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
                  textWidget("Select the type"),
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
                  //         addImageCameraWidget();
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: const Icon(
                  //         Icons.camera_alt,
                  //         color: Color.fromARGB(255, 24, 97, 156),
                  //       )),
                  // ),
                  // Container(
                  //   margin: const EdgeInsets.only(left: 20.0),
                  //   width: 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       border: Border.all(
                  //         color: Colors.grey,
                  //       )),
                  //   child: InkWell(
                  //       onTap: () {
                  //         addImageGalleryWidget();
                  //         Navigator.of(context).pop();
                  //       },
                  //       child: const Icon(
                  //         Icons.photo,
                  //         color: Color.fromARGB(255, 24, 97, 156),
                  //       )),
                  // ),
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
                        onTap: () {
                          addDocumentWidget();
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.document_scanner,
                          color: Color.fromARGB(255, 24, 97, 156),
                        )),
                  )
                ],
              )
            ],
          );
        });
  }

  dropDownRadio(
      List<String> role, String roleValue, void Function(String?)? onChanged) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            
            child: ListView.separated(
              shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                itemCount: role.length,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(role[index]),
                      Radio(
                          value: role[index],
                          groupValue: roleValue,
                          onChanged: onChanged)
                    ],
                  );
                }),
          );
        });
  }
}
