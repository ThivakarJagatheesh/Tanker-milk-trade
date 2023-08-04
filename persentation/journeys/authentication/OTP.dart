// // ignore: file_names
// import 'package:dairy_products/persentation/journeys/dashboard/dashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';
// import '../../../user_detail_collecting.dart';

// class OTPPAGE extends StatefulWidget {
//   const OTPPAGE({ super.key});
//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<OTPPAGE> {
//   OtpFieldController otpController = OtpFieldController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.cleaning_services),
//         onPressed: () {
//           debugPrint("Floating button was pressed.");
//           otpController.clear();
//           // otpController.set(['2', '3', '5', '5', '7']);
//           // otpController.setValue('3', 0);
//           // otpController.setFocus(1);
//         },
//       ),
//       body: Form(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               OTPTextField(
//                   controller: otpController,
//                   length: 4,
//                   width: MediaQuery.of(context).size.width,
//                   textFieldAlignment: MainAxisAlignment.spaceAround,
//                   fieldWidth: 45,
//                   fieldStyle: FieldStyle.box,
//                   outlineBorderRadius: 15,
//                   style: const TextStyle(fontSize: 17),
//                   onChanged: (pin) {
//                     debugPrint("Changed: $pin");
//                   },
//                   onCompleted: (pin) {
//                     debugPrint("Completed: $pin");
//                   }),
//                  const Align(
//                     alignment: Alignment.centerRight,
//                     child:  InkWell(child: Padding(
//                       padding: EdgeInsets.only(right:20.0,top: 20),
//                       child: Text("Resend", style: TextStyle(decoration: TextDecoration.underline,
//                                   color: Colors.blue, fontStyle: FontStyle.italic,fontSize: 16),),
//                     ),),
//                   ),
//               Container(
//                 height: 50,
//                 width: 250,
//                 margin: const EdgeInsets.only(top: 30.0),
//                 decoration: BoxDecoration(
//                 color: Colors.blue, borderRadius: BorderRadius.circular(20)),
//                 child: MaterialButton(
//                 onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (context) {
//                         return const AlertDialog(
//                           // Retrieve the text the that user has entered by using the
//                           // TextEditingController.
//                           content: Text("data"),
//                         );
//                       },
//                     );
//                     Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (_) => const DashboardPage()),
//                         (route) => false);
//                   },
//                   child: const Text(
//                     'Continue',
//                     style: TextStyle(color: Colors.white, fontSize: 21),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
