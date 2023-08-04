import 'package:dairy_products/common/widgets/local_storage/shared_storage.dart';
import 'package:dairy_products/common/widgets/text_form_field_widget.dart';
import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/data/api_config/api_config.dart';
import 'package:dairy_products/di/get_it.dart';
import 'package:dairy_products/persentation/bloc/authentication/authentication_bloc.dart';
import 'package:dairy_products/persentation/bloc/authentication/authentication_state.dart';
import 'package:dairy_products/persentation/journeys/home/home.dart';
import 'package:dairy_products/persentation/journeys/authentication/sign_up.dart';
import 'package:dairy_products/persentation/journeys/trade_info/trade_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});
  @override
  LoginDemoState createState() => LoginDemoState();
}

class LoginDemoState extends State<LoginDemo> {
  var email = TextEditingController();
  var password = TextEditingController();
  bool obsecureText = true;
  var key = GlobalKey<FormState>();
  late AuthenticationBloc authenticationBloc;
  @override
  void initState() {
    authenticationBloc = getItInstance<AuthenticationBloc>();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    //key.currentState!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final myController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(242, 255, 255, 255),
        // const Color.fromARGB(255, 219, 218, 218).withOpacity(1.0),
        body: BlocProvider.value(
          value: authenticationBloc,
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationLoginState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("success")));
                var route = MaterialPageRoute(
                    builder: (context) =>
                        SharedStorage.getBool(ApiConfig.tradeInfo, false) ==
                                false
                            ? const TradeInfoPage()
                            : const HomePage());
                Navigator.pushAndRemoveUntil(context, route, (r) => false);
              }
              if (state is AuthenticationFailure) {
                debugPrint(state.errorMessage);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            },
            builder: (context, state) {
              if (state is AuthenticationLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Form(
                key: key,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // const Text("Welcome!!!",style: TextStyle(letterSpacing:2.0,fontFamily: "Opens-sans",fontSize: 50,color:  Color.fromARGB(
                        //                     255, 24, 97, 156),)),
                        const Wrap(children: [Text("Welcome!",style: TextStyle(fontFamily: "Poppins",fontSize: 40,color:  Color.fromARGB(255, 33, 125, 201),))],),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Center(
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
                        ),
                        TextFormFieldWidgets(
                            controller: email,
                            labelText: "Email",
                            hintText: "Enter the email"),
                        TextFormFieldWidgets(
                          controller: password,
                          labelText: "password",
                          hintText: "Enter the password",
                          obsecureText: obsecureText,
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  obsecureText = !obsecureText;
                                });
                              },
                              child:obsecureText?  const Icon(Icons.visibility_off):const Icon(Icons.visibility)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  var route = MaterialPageRoute(
                                      builder: (context) => const HomePage());
                                  // Navigator.pushAndRemoveUntil(context, route, (r) => false);
                                  // var route = MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         const ());
                                  // Navigator.push(context, route);
                                },
                                child: Text('forgot password?',
                                    style: CommonStyles(context).italicStyle(
                                        color: const Color.fromARGB(
                                            255, 24, 97, 156),
                                        textDecoration:
                                            TextDecoration.underline)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 250,
                          margin: const EdgeInsets.only(top: 20.0, bottom: 10),
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 24, 97, 156),
                              borderRadius: BorderRadius.circular(20)),
                          // margin: const EdgeInsets.all(20),

                          child: MaterialButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                authenticationBloc.loginCubit(
                                    email: email.text, password: password.text);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (_) => const OTPPAGE()));
                              }
                            },
                            child: Text('Continue',
                                style: CommonStyles(context).buttonStyle()),
                          ),
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an Account? ",
                                  style: CommonStyles(context).style()),
                              InkWell(
                                onTap: () {
                                  var route = MaterialPageRoute(
                                      builder: (context) => const SignUp());
                                  Navigator.push(context, route);
                                },
                                child: Text('Sign Up',
                                    style: CommonStyles(context).italicStyle(
                                      color: const Color.fromARGB(
                                          255, 24, 97, 156),
                                    )),
                              )
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 10,),
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
            },
          ),
        ),
      ),
    );
  }
}
