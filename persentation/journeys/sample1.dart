import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/persentation/journeys/authentication/login.dart';
import 'package:dairy_products/persentation/journeys/sample2.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            'assests/taknerlogo.jpg',
            color: Colors.white70,
            colorBlendMode: BlendMode.dstATop,
          )),
          Positioned(bottom: 2,left:10,right:10,child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width/2-20,
                child: MaterialButton(
                  onPressed: (){
                     var newRoute = MaterialPageRoute(builder: (_) {
                      return const LoginDemo();
                    });
                    Navigator.pushAndRemoveUntil(
                        context, newRoute, (route) => false);
                  },color: Colors.green,
                  child: Text("skip",style: CommonStyles(context).buttonStyle(color: Colors.white),),
                  ),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width/2-20,
                child: MaterialButton(onPressed: (){
                   var newRoute = MaterialPageRoute(builder: (_) {
                      return const MyWidgets();
                    });
                    Navigator.pushAndRemoveUntil(
                        context, newRoute, (route) => false);
                },color: Colors.blue,
                 child: Text("next>>",style: CommonStyles(context).buttonStyle(color: Colors.white),),
                )),
            ],
          ),)
        ],
      ),
    );
  }
}
