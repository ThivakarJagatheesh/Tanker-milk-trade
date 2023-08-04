import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/data/models/district.dart';
import 'package:dairy_products/data/models/post_buy_shell_model.dart';
import 'package:dairy_products/data/models/product_model.dart';
import 'package:dairy_products/data/models/state.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/product/product_bloc.dart';
import 'package:dairy_products/persentation/bloc/product/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BuyPostDetailPage extends StatefulWidget {
  const BuyPostDetailPage({super.key});

  @override
  State<BuyPostDetailPage> createState() => _BuyPostDetailPageState();
}

class _BuyPostDetailPageState extends State<BuyPostDetailPage> {
  String category = "Select ";
  String categoryType = "Select ";
  String requirementType = "Select";
  var categoryList = ["Select "];
  var categoryTypesList = ["Select "];

  String productType = '';
  String milkType = "";
  String roleValue = "Select";
  List<ProductBody> categorys = [];
  List<ProductBody> categoryTypes = [];
  var requirementTypes = [
    "Select",
    "One-time",
    "Weekly",
    "Two days",
    "Three days",
    "Four days",
    "Five days",
    "Six days",
    "Seven days"
  ];
  var qtyController = TextEditingController();
  var categoryController = TextEditingController(text: "Selelct");
  var productController = TextEditingController(text: "Selelct");
  
  
  //var chooseFileController = TextEditingController();
  var expectingPriceController = TextEditingController();
  var fatController = TextEditingController();
  var snfController = TextEditingController();
  var mbrtController = TextEditingController();
  var clrController = TextEditingController();
  var ageOfMilkController = TextEditingController();
  late ProductBloc productBloc;
  var dateController = TextEditingController();
   var stateController = TextEditingController(text: "Selelct");
    var districtController = TextEditingController(text: "Selelct");
  String stateValue = "select";
  String districtValue = "select";
  String stateCode = "";
  String districtCode = "";
  List<String> stateList = ["select"];
  List<String> districtList = ["select"];
  List<Statebody> states = [];
  List<DistrictBody> district = [];
  @override
  void initState() {
    productBloc = getItInstance<ProductBloc>();
    Future.microtask(() {
      getProduct();
      getState();
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

  getState() {
    productBloc.getStateList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 24, 97, 156),
          centerTitle: true,
          title: const Text("To Buy Post"),
        ),
        bottomNavigationBar: Container(
          height: 50,
          width: 250,

          margin: const EdgeInsets.only(
              left: 50, right: 50, bottom: 10.0, top: 10.0),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 24, 97, 156),
              borderRadius: BorderRadius.circular(20)),
          // margin: const EdgeInsets.all(20),

          child: MaterialButton(
            onPressed: () {
              submitShell();
            },
            child: const Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 21),
            ),
          ),
        ),
        body: BlocProvider.value(
          value: productBloc,
          child: BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
            if (state is ProductSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                "success",
                style: CommonStyles(context).style(color: Colors.white),
              )));
              Navigator.pop(context);
            }
            if (state is StateListSuccess) {
              if (states.isNotEmpty) {
                stateList.clear();
                states.clear();
              }
              for (var result in state.stateModel.statebody!) {
                states.add(result);
                stateList.add(result.stateName!);
                // stateValue = result.stateName ?? '';
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
                // districtValue = result.districtCode ?? '';
              }
              setState(() {});
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
              // category = state.productModel.body!.first.productTypeName!;
              // productType = state.productModel.body!.first.productTypeId!;
            }
            if (state is SubProductTypeState) {
              categoryTypes.clear();
              categoryTypesList = ["Select"];
              categoryTypes = state.productModel.body!;
              for (var res in categoryTypes) {
                categoryTypesList.add(res.productTypeName!);
              }
              // categoryType = state.productModel.body!.first.productTypeName!;
              //  milkType = state.productModel.body!.first.productTypeId!;
              setState(() {});
            }
          }, builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color.fromARGB(255, 24, 97, 156),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  // textWidget("Category"),
                  TextFormFieldWidgets(
                    labelText: 'Category',
                    hintText: 'Select the category',
                    controller: categoryController,
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onTap: () {
                      dropDownRadio(categoryList, category, (newValue) {
                        for (var res in categorys) {
                          if (res.productTypeName == newValue) {
                            productType = res.productTypeId!;
                          }
                        }
                        categoryTypes = [];
                        categoryType = "";
                        categoryTypesList = [];
                        productController.clear();
                        productBloc.getSubProductType(int.parse(productType));
                        setState(() {
                          category = newValue.toString();
                          categoryController.text = newValue.toString();
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
                    labelText: 'Product',
                    hintText: 'Select the product',
                    controller: productController,
                    keyboardType: TextInputType.text,
                    enabled: categoryTypesList.isNotEmpty?true:false,
                    onTap: () {
                      dropDownRadio(categoryTypesList, categoryType, (newValue) {
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
                  // dropDownField(
                  //   labelText: "category",
                  //   value: category,
                  //   items: categoryList,
                  //   onChanged: (newValue) {
                  //     for (var res in categorys) {
                  //       if (res.productTypeName == newValue) {
                  //         productType = res.productTypeId!;
                  //       }
                  //     }
                  //     productBloc.getSubProductType(int.parse(productType));
                  //     setState(() {
                  //       category = newValue!;
                  //     });
                  //   },
                  // ),
                  // dropDownField(
                  //   labelText: "category type",
                  //   value: categoryType,
                  //   items: categoryTypesList,
                  //   onChanged: (newValue) {
                  //     for (var res in categoryTypes) {
                  //       if (res.productTypeName == newValue) {
                  //         milkType = res.productTypeId!;
                  //       }
                  //     }
                  //     setState(() {
                  //       categoryType = newValue!;
                  //     });
                  //   },
                  // ),
                  // textWidget("Category Type"),
                  // Container(
                  //   width: double.infinity,
                  //   height: 60,
                  //   // width: 250,
                  //   margin: const EdgeInsets.only(
                  //       left: 10.0, right: 10, top: 5.0, bottom: 10.0),
                  //   decoration: BoxDecoration(
                  //       // color: Colors.white,
                  //       border: Border.all(
                  //         color: Colors.grey,
                  //         // width: 1,
                  //       ),
                  //       borderRadius: BorderRadius.circular(10)),
                  //   child: DropdownButtonHideUnderline(
                  //     child: ButtonTheme(
                  //       alignedDropdown: true,
                  //       child: DropdownButton<String>(
                  //         value: categoryType,
                  //         hint: const Text("Please select Type"),
                  //         items: categoryTypes.map((String value) {
                  //           return DropdownMenuItem<String>(
                  //             value: value,
                  //             child: Text(value),
                  //           );
                  //         }).toList(),
                  //         onChanged: (String? newValue) {
                  //           setState(() {
                  //             categoryType = newValue!;
                  //           });
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // textWidget("Req OTY"),
                  TextFormFieldWidgets(
                    // horizontal: 10,
                    // vertical: 5,
                    controller: qtyController,
                    hintText: "In litres (12)", labelText: "Required Qty",
                  ),
                   
                   TextFormFieldWidgets(
                    labelText: 'state',
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
                      productBloc.getDistrictList();
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
                    enabled: districtList.isNotEmpty?true:false,
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
                  // dropDownField(
                  //   labelText: "Preferred state",
                  //   value: stateValue,
                  //   items: stateList,
                  //   onChanged: (newValue) {
                  //     for (var res in states) {
                  //       if (res.stateName == newValue) {
                  //         stateCode = res.stateCode!;
                  //         // milkType = res.productTypeId!;
                  //       }
                  //     }
                  //     setState(() {
                  //       stateValue = newValue!;
                  //     });
                  //     productBloc.getDistrictList();
                  //   },
                  // ),
                  // dropDownField(
                  //   labelText: "Preferred district",
                  //   value: districtValue,
                  //   items: districtList,
                  //   onChanged: (newValue) {
                  //     for (var res in district) {
                  //       if (res.districtCode == newValue) {
                  //         districtCode = res.districtCode!;
                  //       }
                  //     }
                  //     setState(() {
                  //       districtValue = newValue!;
                  //     });
                  //   },
                  // ),
                  TextFormFieldWidgets(
                      controller: dateController,
                      hintText: "Post valid Till",
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
                            dateController.text = DateFormat("dd/MM/yyyy")
                                .format(DateUtils.dateOnly(selectDate));
                          }
                        },
                      )),
                ],
              ),
            );
          }),
        ));
  }

  Widget dropDownField(
      {required String labelText,
      required String value,
      required List<String> items,
      required void Function(String?)? onChanged}) {
    return Container(
      width: double.infinity,
      height: 55,
      // width: 250,
      margin:
          const EdgeInsets.only(left: 15.0, right: 15, top: 10.0, bottom: 10.0),
      decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            // width: 1,
          ),
          borderRadius: BorderRadius.circular(6)),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<String>(
              value: value,
              isDense: false,
              hint: Text(labelText),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: CommonStyles(context).textFormFieldStyle(),
                  ),
                );
              }).toList(),
              onChanged: onChanged),
        ),
      ),
    );
  }
  // return FormField<String>(
  //   initialValue: labelText,
  //   builder: (FormFieldState<String> state) {
  //     return InputDecorator(
  //       expands: false,
  //       decoration: InputDecoration(
  //         contentPadding:
  //             const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
  //         labelText: labelText,
  //         hintText: labelText,
  //         border:
  //             OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  //       ),
  //       isEmpty: value == '',
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton<String>(
  //           value: value,
  //           isDense: true,
  //           onChanged: onChanged,
  //           items: items.map((String values) {
  //             return DropdownMenuItem<String>(
  //               value: values,
  //               child: Text((values)),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     );
  //   },

  //   // child: ButtonTheme(
  //   //   alignedDropdown: true,
  //   //   child: DropdownButton<String>(
  //   //     value: category,
  //   //     hint: const Text("Please select Type"),
  //   //     items: categorys.map((String value) {
  //   //       return DropdownMenuItem<String>(
  //   //         value: value,
  //   //         child: Text(value),
  //   //       );
  //   //     }).toList(),
  //   //     onChanged: (String? newValue) {
  //   //       setState(() {
  //   //         category = newValue!;
  //   //       });
  //   //     },
  //   //   ),
  //   // ),
  // );
  // }

  Widget textWidget(String data) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
      ),
      child: Text(data),
    );
  }

  submitShell() {
    ShellBuyBody shellBuyBody = ShellBuyBody()
      ..userId = SharedStorage.getString(ApiConfig.userId)
      ..ageOfMilk = ageOfMilkController.text
      ..avaiablequanitity = qtyController.text
      ..email = "iamthivakar007@gmail.com"
      ..fat = fatController.text
      ..labreportFile = null
      ..prductImage = null
      ..mbrt = mbrtController.text
      ..postType = "BUY"
      ..price = expectingPriceController.text
      ..milkType = milkType
      ..productType = productType
      ..productName = category
      ..subProducttypeName = categoryType
      ..productTypeName = requirementType
      ..snf = snfController.text
      ..mobile = "1234567890"
      ..postCreatedDateTime = DateTime.now()
      ..postExpiredDateTime = DateTime.now();

    productBloc.addProduct(shellBuyBody);
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("please select the image")));
    // }
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
                          onChanged: onChanged
                        
                          )
                    ],
                  );
                }),
          );
        });
  }
}
