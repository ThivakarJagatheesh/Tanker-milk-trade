import 'package:flutter/material.dart';

class CommonStyles {
  final BuildContext context;
  CommonStyles(this.context);

  TextStyle appBarStyle({Color? color}) {
    return  TextStyle(
      fontFamily: "OpenSans",
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.3,
      color: color??Colors.white
    );
  }

  TextStyle buttonStyle({Color? color}) {
      return  TextStyle(
      fontFamily: "Poppins",
      fontSize: 18,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: color??Colors.white
    );
  }
  TextStyle hintStyle({Color? color,double? fontSize}) {
      return  TextStyle(
      fontFamily: "OpenSans",
      fontSize: fontSize??16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color??Colors.grey
    );
  }
  TextStyle textFormFieldStyle({Color? color}) {
      return  TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: color??Colors.black
    );
  }
  TextStyle dashboardStyle({Color? color}) {
      return  TextStyle(
      fontFamily: "OpenSans",
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
      color: color??Colors.black
    );
  }

    TextStyle style({Color? color}) {
      return  TextStyle(
      fontFamily: "Poppins",
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.05,
      color: color??Colors.black
    );
  }
    TextStyle italicStyle({Color? color,TextDecoration? textDecoration}) {
      return  TextStyle(
      fontFamily: "Poppins",
      fontStyle: FontStyle.italic,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      color: color??Colors.black,
      decoration: textDecoration
    );
  }
}
