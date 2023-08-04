import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/persentation/journeys/trade_info/trade_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:otp_text_field/otp_field.dart';

import 'package:dairy_products/data/models/signup.dart';
import 'package:dairy_products/di/get_it.dart';

import '../../bloc/authentication/authentication_bloc.dart';
import '../../bloc/authentication/authentication_state.dart';

enum Gender { male, female }

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<SignUp> {
  // OtpFieldController otpController = OtpFieldController();
  var dateController = TextEditingController();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var password = TextEditingController();
  var role = TextEditingController(text: "Select");
  var designation = TextEditingController(text: "Select");
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
  // Gender gender = Gender.male;
  var formKey = GlobalKey<FormState>();

  // void onChangedGender(v) {
  //   setState(() {
  //     gender = v;
  //   });
  // }

  late AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = getItInstance<AuthenticationBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 24, 97, 156),
            centerTitle: true,
            title: Text('Registration',
                style: CommonStyles(context).appBarStyle())),
        body: BlocProvider.value(
            value: authenticationBloc,
            child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
              if (state is AuthenticationSignupState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("success")));
                var route = MaterialPageRoute(
                    builder: (context) => const TradeInfoPage());
                Navigator.pushAndRemoveUntil(context, route, (r) => false);
              }
              if (state is AuthenticationFailure) {
                debugPrint(state.errorMessage);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            }, builder: (context, state) {
              if (state is AuthenticationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                              width: 150,
                              height: 100,
                              /*decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50.0)),*/
                              child: Image.asset(
                                  'assests/taknerlogo.jpg',
                                  fit: BoxFit.cover,
                                  color: Colors.white70,
                                  colorBlendMode: BlendMode.dstATop,
                                )),
                        ),
                        TextFormFieldWidgets(
                          labelText: 'Name',
                          hintText: 'Enter the name',
                          controller: firstName,
                          keyboardType: TextInputType.text,
                        ),
                        // TextFormFieldWidgets(
                        //   labelText: 'Last Name',
                        //   hintText: 'Enter Last Name',
                        //   controller: lastName,
                        //   keyboardType: TextInputType.text,
                        // ),
                        TextFormFieldWidgets(
                          labelText: 'Email',
                          hintText: 'sample@email.test',
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //         width: MediaQuery.of(context).size.width / 2,
                        //         child: RadioListTile(
                        //             title: Text(
                        //               "Male",
                        //               style: CommonStyles(context).style(),
                        //             ),
                        //             value: Gender.male,
                        //             groupValue: gender,
                        //             activeColor:
                        //                 const Color.fromARGB(255, 24, 97, 156),
                        //             onChanged: onChangedGender)),
                        //     SizedBox(
                        //         width: MediaQuery.of(context).size.width / 2,
                        //         child: RadioListTile(
                        //             title: Text(
                        //               "Female",
                        //               style: CommonStyles(context).style(),
                        //             ),
                        //             value: Gender.female,
                        //             groupValue: gender,
                        //             activeColor:
                        //                 const Color.fromARGB(255, 24, 97, 156),
                        //             onChanged: onChangedGender))
                        //   ],
                        // ),

                        // TextFormFieldWidgets(
                        //     controller: dateController,
                        //     hintText: "Date of Birth",
                        //     suffixIcon: InkWell(
                        //       child: const Icon(
                        //         Icons.calendar_month,
                        //         color: Color.fromARGB(255, 24, 97, 156),
                        //       ),
                        //       onTap: () async {
                        //         //  DatePickerDialog(initialDate: DateTime.now(),firstDate: DateTime(1950),lastDate: DateTime.now(),).currentDate;
                        //         final selectDate = await showDatePicker(
                        //             context: context,
                        //             initialDate: DateTime.now(),
                        //             firstDate: DateTime(1950),
                        //             lastDate: DateTime.now());

                        //         if (selectDate != null) {
                        //           dateController.text = DateFormat("dd/MM/yyyy")
                        //               .format(DateUtils.dateOnly(selectDate));
                        //         }
                        //       },
                        //     )),
                        TextFormFieldWidgets(
                          labelText: 'MobileNumber',
                          hintText: 'Enter mobile number',
                          controller: mobile,
                          keyboardType: TextInputType.text,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 15.0, vertical: 8),
                        //   child: dropDownField(
                        //     labelText: "Designation",
                        //     value: designationValue,
                        //     items: designations,
                        //     onChanged: (newValue) {
                        //       setState(() {
                        //         designationValue = newValue!;
                        //       });
                        //     },
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 15.0, vertical: 8),
                        //   child: dropDownField(
                        //     labelText: "Role",
                        //     value: roleValue,
                        //     items: roles,
                        //     onChanged: (newValue) {
                        //       setState(() {
                        //         roleValue = newValue!;
                        //       });
                        //     },
                        //   ),
                        // ),
                        TextFormFieldWidgets(
                          labelText: 'Designation',
                          hintText: 'Select the designation',
                          controller: designation,
                          keyboardType: TextInputType.text,
                          suffixIcon: InkWell(
                              onTap: () {
                                dropDownRadio(designations, designation,designationValue);
                              },
                              child: const Icon(Icons.arrow_drop_down,size: 30,)),
                        ),
                        TextFormFieldWidgets(
                          labelText: 'Role',
                          hintText: 'Select the role',
                          controller: role,
                          keyboardType: TextInputType.text,
                          suffixIcon: InkWell(
                              onTap: () {
                                dropDownRadio(roles, role,roleValue);
                              },
                              child: const Icon(Icons.arrow_drop_down,size: 30,)),
                        ),
                        TextFormFieldWidgets(
                          labelText: 'Password',
                          hintText: 'Enter password',
                          controller: password,
                          keyboardType: TextInputType.text,
                        ),
                        
                        Container(
                          height: 50,
                          width: 250,
                          margin: const EdgeInsets.only(top: 30.0),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 24, 97, 156),
                              borderRadius: BorderRadius.circular(20)),
                          // margin: const EdgeInsets.all(20),

                          child: MaterialButton(
                            onPressed: () {
                              //               var route = MaterialPageRoute(
                              //     builder: (context) => const TradeInfoPage());
                              // Navigator.pushAndRemoveUntil(context, route, (r) => false);
                              if (formKey.currentState!.validate()) {
                                SignupModel signupModel = SignupModel();
                                signupModel.firstname = firstName.text;
                                signupModel.lastname = designationValue;
                                signupModel.dob = roleValue;
                                signupModel.email = email.text;
                                signupModel.mobilenumber = mobile.text;
                                signupModel.password = password.text;
                                // signupModel.gender =
                                //     gender == Gender.male ? "Male" : "Female";
                                authenticationBloc.signupCubit(
                                    signupModel: signupModel);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => const OTPPAGE()));
                              }
                            },
                            child: Text('Continue',
                                style: CommonStyles(context).buttonStyle()),
                          ),
                        ),const SizedBox(height: 10,),

                       RichText(text:  TextSpan(
                          children: [
                            TextSpan(text: "By registering you agree ",style: CommonStyles(context).style(color: Colors.grey)),
                            TextSpan(text: "Terms of use",style: CommonStyles(context).style(color: 
                            const Color.fromARGB(
                                          255, 24, 97, 156)))
                          ]
                        ))
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }

  FormField<String> dropDownField(
      {required String labelText,
      required String value,
      required List<String> items,
      required void Function(String?)? onChanged}) {
    return FormField<String>(
      initialValue: labelText,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          expands: false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            // labelText: labelText,
            hintText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: items.map((String values) {
                return DropdownMenuItem<String>(
                  value: values,
                  child: Text(values),
                );
              }).toList(),
            ),
          ),
        );
      },

      // child: ButtonTheme(
      //   alignedDropdown: true,
      //   child: DropdownButton<String>(
      //     value: category,
      //     hint: const Text("Please select Type"),
      //     items: categorys.map((String value) {
      //       return DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       );
      //     }).toList(),
      //     onChanged: (String? newValue) {
      //       setState(() {
      //         category = newValue!;
      //       });
      //     },
      //   ),
      // ),
    );
  }


  dropDownRadio(List<String> role, TextEditingController value,String changeValue) {
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
                          onChanged: (newValue) {
                            setState(() {
                              roleValue = newValue.toString();
                              value.text = newValue.toString();
                            });
                            Navigator.pop(context);
                          })
                    ],
                  );
                }),
          );
        });
  }
}
