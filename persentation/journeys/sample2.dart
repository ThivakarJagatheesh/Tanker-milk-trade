import 'package:dairy_products/common/widgets/text_style.dart';
import 'package:dairy_products/persentation/journeys/authentication/login.dart';
import 'package:flutter/material.dart';

class MyWidgets extends StatelessWidget {
  const MyWidgets({super.key});

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
          Positioned(
            bottom: -5,
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width ,
                child: MaterialButton(
                  onPressed: () {
                    var newRoute = MaterialPageRoute(builder: (_) {
                      return const LoginDemo();
                    });
                    Navigator.pushAndRemoveUntil(
                        context, newRoute, (route) => false);
                  },
                  color: Colors.blue,
                  child: Text(
                    "Get Started",
                    style: CommonStyles(context).buttonStyle(color: Colors.white),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
