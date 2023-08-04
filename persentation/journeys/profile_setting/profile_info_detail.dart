import 'dart:io';

import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/profile_model.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/profile_trade/profile_trade_bloc.dart';
import 'package:dairy_products/persentation/bloc/profile_trade/profile_trade_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';

class ProfileInfoDetail extends StatefulWidget {
  const ProfileInfoDetail({super.key});

  @override
  State<ProfileInfoDetail> createState() => _ProfileInfoDetailState();
}

class _ProfileInfoDetailState extends State<ProfileInfoDetail> {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var designationController = TextEditingController();
  var emailController = TextEditingController();
  var mobileNoController = TextEditingController();
  late ProfileTradeBloc profileBloc;
  XFile? fileImage;
  late String? localStorageImage;
  UserInfo? userInfo = UserInfo();
  late int userId;
  bool update = false;
  String buttonlabel = "update  ";
  var designations = [
    "Select",
    "chairman",
    "Managing Director",
    "Director",
    "Proportior",
    "Partner",
    "General managers",
    "manager",
    "others"
  ];
  String designationValue = "Select";
  var roles = [
    "Select",
    "Dairy Operator",
    "Chilling Center Operator",
    "Trader",
    "Transporter",
    "Driver",
    "others"
  ];
  String roleValue = "Select";
  //var firstNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    profileBloc = getItInstance();
    String id = SharedStorage.getString(ApiConfig.userId, "");
    if (id != "") {
      userId = int.parse(id);
      profileBloc.getProfileList(userId: userId);
    }

    // firstNameController.text = SharedStorage.getString("firstName");
    // lastNameController.text = SharedStorage.getString("role");
    // emailController.text = SharedStorage.getString("email");
    // mobileNoController.text = SharedStorage.getString("phone");
    designationController.text = SharedStorage.getString("designation");
    localStorageImage = SharedStorage.getString("profile_image", null);
    if (localStorageImage != "") {
      fileImage = XFile(localStorageImage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile Info",
          style: CommonStyles(context).appBarStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 24, 97, 156),
        actions: [
          update == false
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
                          UserInfo userData = UserInfo()
                            ..email = emailController.text
                            ..firstName = firstNameController.text
                            ..lastName = lastNameController.text
                            ..mobile = mobileNoController.text
                            ..userId = SharedStorage.getString(ApiConfig.userId)
                            ..profile =
                                fileImage != null ? fileImage!.path : '';

                          ProfileBody profileBody =
                              ProfileBody(userInfo: userData);
                          profileBloc.updateTradeAccount(profileBody);
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
        ],
      ),
      body: BlocProvider.value(
        value: profileBloc,
        child: BlocConsumer<ProfileTradeBloc, ProfileTradeState>(
            listener: (context, state) {
          if (state is ProfileListState) {
            if (state.profileModel.body != null) {
              for (var user in state.profileModel.body!) {
                userInfo = user.userInfo!;
              }
              setState(() {
                firstNameController.text = userInfo!.firstName ?? '';
                lastNameController.text = userInfo!.lastName ?? '';
                emailController.text = userInfo!.email ?? '';
                mobileNoController.text = userInfo!.mobile ?? '';
              });
            }
          }
          if (state is UpdateTradeState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              state.message.message ?? 'Success',
              style: CommonStyles(context).style(color: Colors.white),
            )));
            profileBloc.getProfileList();
          }
        }, builder: (context, state) {
          if (state is ProfileTradeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                fileImage == null
                    ? Container(
                        width: 150,
                        height: 120,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, border: Border.all()),
                        child: InkWell(
                          onTap: () {
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
                            onTap: () {
                              bottomSheetImage();
                            },
                            child: CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  File(fileImage!.path),
                                )),
                          )
                        : InkWell(
                            onTap: () {
                              bottomSheetImage();
                            },
                            child: CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    NetworkImage(userInfo!.profile!)),
                          ),
                // const Spacer(),
                TextFormFieldWidgets(
                  controller: firstNameController,
                  hintText: "Enter the Name",
                  labelText: "Enter Name",
                  enabled: update,
                ),
                TextFormFieldWidgets(
                  controller: emailController,
                  hintText: "Enter the Email",
                  labelText: " Email",
                  enabled: update,
                ),
                // const Spacer(),
                TextFormFieldWidgets(
                  controller: mobileNoController,
                  hintText: "Enter the MobileNo",
                  labelText: " MobileNo",
                  enabled: update,
                  maxlength: 10,
                  keyboardType: TextInputType.phone,
                ),
                // const Spacer(),

                // const Spacer(),

                TextFormFieldWidgets(
                  controller: designationController,
                  hintText: "Enter the Designation",
                  labelText: " Designation",
                  enabled: update,
                  keyboardType: TextInputType.text,
                  onTap: () {
                    dropDownRadio(designations, designationValue, (newValue) {
                      setState(() {
                        designationValue = newValue.toString();
                        designationController.text = newValue.toString();
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
                  controller: lastNameController,
                  hintText: "Enter the role",
                  labelText: " Role",
                  enabled: update,
                  keyboardType: TextInputType.text,
                  onTap: () {
                    dropDownRadio(roles, roleValue, (newValue) {
                      setState(() {
                        roleValue = newValue.toString();
                        lastNameController.text = newValue.toString();
                      });
                      Navigator.pop(context);
                    });
                  },
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                  ),
                ),

                // const Spacer(),
              ],
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
      final fileName = path.basename(file.path);
      await file.saveTo("${dir.path}/$fileName");
      fileImage = XFile(file.path);
      debugPrint(" file image is ${dir.path}/$fileName}");
      await SharedStorage.setString("profile_image", fileImage!.path);
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
      await SharedStorage.setString("profile_image", fileImage!.path);
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
