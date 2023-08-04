import 'dart:io';

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/data/models/trade_nature_model.dart';
import 'package:dairy_products/data/models/trade_type_model.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/profile_trade/profile_trade_bloc.dart';
import 'package:dairy_products/persentation/bloc/profile_trade/profile_trade_state.dart';
import 'package:dairy_products/persentation/journeys/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TradeInfoPage extends StatefulWidget {
  const TradeInfoPage({super.key});
  @override
  TradePageState createState() => TradePageState();
}

class TradePageState extends State<TradeInfoPage> {
  var tradeContactNoController = TextEditingController();
  var tradeNameController = TextEditingController();
  var gstController = TextEditingController();
  var fssaiNoController = TextEditingController();
  var pinController = TextEditingController();
  var tradeEmailController = TextEditingController();
  var addressController = TextEditingController();
  var locationController = TextEditingController();
  var tradeKey = GlobalKey<FormState>();
  String dropdownvalue = 'Dairy';

  var items1 = [
    'Dairy',
    'CC',
    'Trader',
  ];
  var stateController = TextEditingController();
  var districtController = TextEditingController();
  var trade = TextEditingController();
  String stateValue = "";
  String districtValue = "";
  String stateCode = "";
  String districtCode = "";
  List<String> stateList = [];
  List<String> districtList = [];
  List<Statebody> states = [];
  List<DistrictBody> district = [];
  List<String> tradeNatures = [];
  List<String> tradeTypes = [];
  List<TradeNatureBody> tradeNaturesBody = [];
  List<TradeTypeBody> tradeTypesbody = [];
  String? tradeNature;
  String? tradeType;
  int? userId;
  String? tradeTypeCode;
  String? tradeNatureCode;
  late String id;
  late ProfileTradeBloc profileTradeBloc;

  TradeInfo tradeInfo = TradeInfo();

  XFile? fileImage;

  String localStorageImage = "";
  bool update = false;
  String buttonlabel = "update  ";

  @override
  void initState() {
    profileTradeBloc = getItInstance<ProfileTradeBloc>();
    id = SharedStorage.getString(ApiConfig.userId, "");
    localStorageImage = SharedStorage.getString("trade_logo", null);
    if (localStorageImage != "") {
      fileImage = XFile(localStorageImage);
    }
    if (id != "") {
      userId = int.parse(id);
    }
    getTradeNature();
    getTradeType();
    getStateList();
    super.initState();
  }

  getTradeNature() {
    profileTradeBloc.getTradeNature();
  }

  getTradeType() {
    profileTradeBloc.getTradeType();
  }

  getStateList() {
    profileTradeBloc.getStateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        centerTitle: true,
        title: Text(
          "Business Info",
          style: CommonStyles(context).appBarStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // if (id == "") {
              //   var route =
              //       MaterialPageRoute(builder: (context) => const LoginDemo());
              //   Navigator.pushAndRemoveUntil(context, route, (r) => false);
              // } else {
              Navigator.pop(context);
              // }
            }),
        actions: [
          SharedStorage.getBool(ApiConfig.tradeInfo, false) == true
              ? update == false
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            update = true;
                            buttonlabel = "Done    ";
                          });
                        },
                        child: Text(
                          buttonlabel,
                          style: CommonStyles(context)
                              .italicStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            // if (userInfo != null)
                            if (buttonlabel == "Done    ") {
                              ProfileBody profileBody = ProfileBody();
                              TradeInfo tradeInfo = TradeInfo();
                              tradeInfo.tradeName = tradeNameController.text;
                              tradeInfo.natureName = tradeNatureCode;
                              tradeInfo.tradeTypeName = tradeType;
                              tradeInfo.tradeTypeCode = tradeTypeCode;
                              tradeInfo.gst = gstController.text;
                              tradeInfo.fssai = fssaiNoController.text;
                              tradeInfo.pin = pinController.text;
                              tradeInfo.stateId = stateValue;
                              tradeInfo.districtId = districtValue;
                              tradeInfo.tradeEmail = tradeEmailController.text;
                              tradeInfo.tradeContactNumber =
                                  tradeContactNoController.text;
                              tradeInfo.address = addressController.text;
                              tradeInfo.tradeLogo = null;
                              // fileImage?.path ?? localStorageImage;
                              profileBody.tradeInfo = tradeInfo;
                              if (SharedStorage.getBool(
                                      ApiConfig.tradeInfo, false) ==
                                  false) {
                                profileTradeBloc.addTradeAccount(profileBody);
                              } else {
                                profileTradeBloc
                                    .updateTradeAccount(profileBody);
                              }
                            }
                          });
                        },
                        child: Text(
                          buttonlabel,
                          style: CommonStyles(context)
                              .italicStyle(color: Colors.white),
                        ),
                      ),
                    )
              : const Column()
        ],
      ),
      body: BlocProvider.value(
        value: profileTradeBloc,
        child: BlocConsumer<ProfileTradeBloc, ProfileTradeState>(
            listener: (context, state) async {
          if (state is ProfileTradeSuccess) {
            await SharedStorage.setBool(ApiConfig.tradeInfo, true);
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("success")));
              var route =
                  MaterialPageRoute(builder: (context) => const HomePage());
              Navigator.pushAndRemoveUntil(context, route, (r) => false);
            }
          }
          if (state is UpdateTradeState) {
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Update")));
              Navigator.pop(context);
              // var route =
              //     MaterialPageRoute(builder: (context) => const HomePage());
              // Navigator.pushAndRemoveUntil(context, route, (r) => false);
            }
          }
          if (state is TradeNatureState) {
            if (state.tradeNatureModel.body != null) {
              tradeNaturesBody = state.tradeNatureModel.body!;
              tradeNatureCode = state.tradeNatureModel.body!.first.tradeCode;
              for (var name in tradeNaturesBody) {
                tradeNatures.add(name.tradeName!);
              }
            }
            if (tradeNatures.isNotEmpty) {
              tradeNature = tradeNatures.first;
            }
            setState(() {});
          }
          if (state is TradeTypeState) {
            if (state.tradeTypeModel.body != null) {
              tradeTypesbody = state.tradeTypeModel.body!;
              tradeTypeCode = state.tradeTypeModel.body!.first.tradtypeCode;
              for (var name in tradeTypesbody) {
                tradeTypes.add(name.typeName!);
              }
              if (tradeTypes.isNotEmpty) {
                tradeType = tradeTypes.first;
              }

              profileTradeBloc.getProfileList(userId: userId);
              setState(() {});
            }
          }
          if (state is ProfileListState) {
            if (state.profileModel.body != null) {
              for (var trade in state.profileModel.body!) {
                tradeInfo = trade.tradeInfo!;
              }
              tradeNameController.text = tradeInfo.tradeName ?? '';
              tradeNatureCode = tradeInfo.natureId ?? '';
              tradeType = tradeInfo.tradeTypeName ?? '';
              tradeTypeCode = tradeInfo.tradeTypeCode ?? '';
              gstController.text = tradeInfo.gst ?? '';
              fssaiNoController.text = tradeInfo.fssai ?? '';
              pinController.text = tradeInfo.pin ?? '';
              // stateValue = tradeInfo.stateName ?? '';
              // districtValue = tradeInfo.districtName ?? '';
              tradeEmailController.text = tradeInfo.tradeEmail ?? '';
              localStorageImage = tradeInfo.tradeLogo ??
                  SharedStorage.getString("trade_logo", "");
              tradeContactNoController.text =
                  tradeInfo.tradeContactNumber ?? '';
              addressController.text = tradeInfo.address ?? '';
            }
            setState(() {});
          }
          if (state is StateListSuccess) {
            for (var result in state.stateModel.statebody!) {
              states.add(result);
              stateList.add(result.stateName!);
              stateValue = result.stateName ?? '';
            }
            setState(() {});
          }
          if (state is DistrictListSuccess) {
            if (district.isNotEmpty) {
              district.clear();
              districtList.clear();
            }
            for (var result in state.districtModel.body!) {
              district.add(result);
              districtList.add(result.districtCode!);
              districtValue = result.districtCode ?? '';
            }
            setState(() {});
          }
          if (state is ProfileTradeFailure) {
            debugPrint(state.errorMessage);
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          }
        }, builder: (context, state) {
          if (state is ProfileTradeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: tradeKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0),
                    //   child: Center(
                    //     child: SizedBox(
                    //         width: 200,
                    //         height: 150,
                    //         /*decoration: BoxDecoration(
                    //               color: Colors.red,
                    //               borderRadius: BorderRadius.circular(50.0)),*/
                    //         child: Image.asset('assests/taknerlogo.jpg')),
                    //   ),
                    // ),
                    // Container(
                    //     alignment: Alignment.center,
                    //     //padding: const EdgeInsets.all(10),
                    //     child: const Text(
                    //       'Trade Info',
                    //       style: TextStyle(
                    //           color: const Color.fromARGB(255, 24, 97, 156),,
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 30),
                    //     )),
                    fileImage == null
                        ? Container(
                            width: 150,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, border: Border.all()),
                            child: InkWell(
                              onTap: () async {
                                // fileImage = await CameraPage()
                                //     .bottomSheetImage(context, fileImage);
                                // debugPrint("fileImage is $fileImage");
                                // setState(() {});
                                bottomSheetImage();
                              },
                              child: const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : fileImage != null
                            ? InkWell(
                                onTap: () async {
                                  // fileImage = await CameraPage()
                                  //     .bottomSheetImage(context, fileImage);
                                  bottomSheetImage();
                                },
                                child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: FileImage(
                                      File(fileImage!.path),
                                    )),
                              )
                            : InkWell(
                                onTap: () async {
                                  // fileImage = await CameraPage()
                                  //     .bottomSheetImage(context, fileImage);
                                  // setState(() {});
                                  bottomSheetImage();
                                },
                                child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        tradeInfo.tradeLogo ?? '')),
                              ),
                    // Container(
                    //   width: double.infinity,
                    //   height: 55,
                    //   // width: 250,
                    //   margin: const EdgeInsets.only(
                    //       left: 15.0, right: 15.0, top: 7, bottom: 7),
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
                    //         value: tradeNature,
                    //         isDense: false,
                    //         hint: const Text("Please select Type"),
                    //         items: tradeNatures.map((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Text(value),
                    //           );
                    //         }).toList(),
                    //         onChanged: (String? newValue) {
                    //           for (var name in tradeNaturesBody) {
                    //             if (name.tradeName == newValue) {
                    //               tradeNatureCode = name.tradeCode;
                    //             }
                    //           }
                    //           setState(() {
                    //             tradeNature = newValue!;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    TextFormFieldWidgets(
                      controller: tradeNameController,
                      labelText: "Business name",
                      hintText: " Enter BusinessName",
                      enabled: update,
                    ),
                
                    TextFormFieldWidgets(
                      labelText: 'Business',
                      hintText: 'Select the business',
                      controller: trade,
                      keyboardType: TextInputType.text,
                      enabled: districtList.isNotEmpty ? true : false,
                      onTap: () {
                        dropDownRadio(tradeTypes, tradeType!, (newValue) {
                          for (var name in tradeTypesbody) {
                            if (name.typeName == newValue) {
                              tradeTypeCode = name.tradtypeCode;
                            }
                          }

                          setState(() {
                            tradeType = newValue.toString();
                            trade.text = newValue.toString();
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
                        controller: gstController,
                        hintText: " Enter GST",
                        labelText: "GST no",
                        enabled: update),
                    TextFormFieldWidgets(
                        controller: fssaiNoController,
                        labelText: "FSSAI",
                        hintText: " Enter FSSAI",
                        enabled: update),
                    TextFormFieldWidgets(
                        controller: pinController,
                        labelText: "PIN code",
                        hintText: " Enter Pin code",
                  keyboardType: TextInputType.number,
                        enabled: update),

                    // Container(
                    //   width: 330.0,
                    //   height: 50,
                    //   // width: 250,
                    //   // margin: const EdgeInsets.only(top: 30.0),
                    //   decoration: BoxDecoration(
                    //       // color: Colors.white,
                    //       border: Border.all(
                    //         color: Colors.grey,
                    //         // width: 1,
                    //       ),
                    //       borderRadius: BorderRadius.circular(10)
                    //   ),
                    //   child: DropdownButtonHideUnderline(
                    //     child: ButtonTheme(
                    //       alignedDropdown: true,
                    //       child: DropdownButton<String>(
                    //         value: dropdownvalue,
                    //         hint: const Text("Please select Type"),
                    //         items: items1.map((String value) {
                    //           return DropdownMenuItem<String>(
                    //             value: value,
                    //             child: Text(value),
                    //           );
                    //         }).toList(),
                    //         onChanged: (String? newValue) {
                    //           setState(() {
                    //             dropdownvalue = newValue!;
                    //           });
                    //         },
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    TextFormFieldWidgets(
                      labelText: 'State',
                      hintText: 'Select the state',
                      controller: stateController,
                      keyboardType: TextInputType.text,
                      enabled: true,
                      onTap: () {
                        dropDownRadio(stateList, stateValue, (newValue) {
                          for (var res in states) {
                            if (res.stateName == newValue) {
                              stateCode = res.stateCode!;
                              // milkType = res.productTypeId!;
                            }
                          }
                          profileTradeBloc.getDistrictList();
                          setState(() {
                            stateValue = newValue.toString();
                            stateController.text = newValue.toString();
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
                      labelText: 'District',
                      hintText: 'Select the district',
                      controller: districtController,
                      keyboardType: TextInputType.text,
                      enabled: districtList.isNotEmpty ? true : false,
                      onTap: () {
                        dropDownRadio(districtList, districtValue, (newValue) {
                          for (var res in district) {
                            if (res.districtCode == newValue) {
                              districtCode = res.districtCode!;
                            }
                          }

                          setState(() {
                            districtValue = newValue.toString();
                            districtController.text = newValue.toString();
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
                        controller: addressController,
                        hintText: 'Address',
                        labelText: "Enter the address",
                        enabled: update),
                    TextFormFieldWidgets(
                      controller: tradeEmailController,
                      labelText: "Business email",
                      hintText: " Enter Business email",
                      enabled: update,
                    ),

                    TextFormFieldWidgets(
                        controller: tradeContactNoController,
                        labelText: 'Business Contact No',
                        hintText: "Enter the Contact No",
                        maxlength: 10,
                  keyboardType: TextInputType.phone,
                        enabled: update),
                    SharedStorage.getBool(ApiConfig.tradeInfo, false) == false
                        ? Container(
                            height: 50,
                            width: 250,

                            margin:
                                const EdgeInsets.only(bottom: 10.0, top: 10.0),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 24, 97, 156),
                                borderRadius: BorderRadius.circular(20)),
                            // margin: const EdgeInsets.all(20),

                            child: MaterialButton(
                              onPressed: () {
                                ProfileBody profileBody = ProfileBody();
                                TradeInfo tradeInfo = TradeInfo();
                                tradeInfo.tradeName = tradeNameController.text;
                                tradeInfo.natureName = tradeNatureCode;
                                tradeInfo.tradeTypeName = tradeType;
                                tradeInfo.tradeTypeCode = tradeTypeCode;
                                tradeInfo.gst = gstController.text;
                                tradeInfo.fssai = fssaiNoController.text;
                                tradeInfo.pin = pinController.text;
                                tradeInfo.stateId = stateValue;
                                tradeInfo.districtId = districtValue;
                                tradeInfo.tradeEmail =
                                    tradeEmailController.text;
                                tradeInfo.tradeContactNumber =
                                    tradeContactNoController.text;
                                tradeInfo.address = addressController.text;
                                tradeInfo.tradeLogo = null;
                                // fileImage?.path ?? localStorageImage;
                                profileBody.tradeInfo = tradeInfo;
                                if (SharedStorage.getBool(
                                        ApiConfig.tradeInfo, false) ==
                                    false) {
                                  profileTradeBloc.addTradeAccount(profileBody);
                                } else {
                                  profileTradeBloc
                                      .updateTradeAccount(profileBody);
                                }
                              },
                              child: Text(
                                'Go to dashboard',
                                style: CommonStyles(context)
                                    .buttonStyle(color: Colors.white),
                              ),
                            ),
                          )
                        : const Column()
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
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
                        onTap: () {
                          addImageCameraWidget();
                          Navigator.of(context).pop();
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
                        onTap: () {
                          addImageGalleryWidget();
                          Navigator.of(context).pop();
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
  }

  addImageCameraWidget() async {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    Directory dir = await getApplicationDocumentsDirectory();

    if (file != null) {
      // final fileName = path.basename(file.path);
      // await file.saveTo("${dir.path}/$fileName");
      fileImage = XFile(file.path);
      debugPrint(" file image is ${dir.path}");
      await SharedStorage.setString("trade_logo", fileImage!.path);
    }
    if (mounted) {
      setState(() {});
    }
  }

  addImageGalleryWidget() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    Directory dir = await getApplicationDocumentsDirectory();

    if (file != null) {
      // final fileName = path.basename(file.path);
      // await file.saveTo("${dir.path}/$fileName");
      fileImage = XFile(file.path);
      debugPrint(" file image is ${dir.path}}");
      await SharedStorage.setString("trade_logo", fileImage!.path);
    }
    if (mounted) {
      setState(() {});
    }
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
