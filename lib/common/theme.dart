import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

Color darkBlue = const Color(0xff1F1D2B);
Color milkWhite = const Color(0xffF1F0F2);
Color white = const Color(0xffFFFFFF);
Color darkGrey = const Color(0xff504F5E);
Color grey = const Color(0xff999999);
Color blue = const Color(0xff0B6994);
Color tosca = const Color(0xff38ABBE);
Color red = const Color(0xffF05454);
Color green = const Color(0xff064663);
Color yellow = const Color(0xffECB365);
Color task = const Color(0xff252836);
Color filter = const Color(0xff242231);
Color textField = const Color(0xff2B2937);
Color navbar = const Color(0xff252837);
Color navItem = const Color(0xff808191);

double defaultMargin = 30.0;

final headline1 = GoogleFonts.montserrat(
  fontSize: 36,
  fontWeight: FontWeight.w500,
  color: milkWhite,
);

final headline2 = GoogleFonts.poppins(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: milkWhite,
);

final headline3 = GoogleFonts.poppins(
  fontSize: 22,
  fontWeight: FontWeight.w600,
  color: milkWhite,
);

final headline4 = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w500,
  color: milkWhite,
);

final headline5 = GoogleFonts.poppins(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: milkWhite,
);

final button = GoogleFonts.poppins(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  letterSpacing: 1.25,
  color: milkWhite,
);

final overline = GoogleFonts.poppins(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: darkGrey,
);

final subtitle1 = GoogleFonts.poppins(
  fontSize: 15,
  fontWeight: FontWeight.w600,
  color: milkWhite,
);

final subtitle2 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: milkWhite,
);

final bodyText1 =
    GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: grey);

final bodyText2 = GoogleFonts.poppins(
  fontSize: 18,
  fontWeight: FontWeight.w500,
  color: white,
);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.montserrat(
    fontSize: 36,
    fontWeight: FontWeight.w500,
    color: milkWhite,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: milkWhite,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: milkWhite,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: milkWhite,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: milkWhite,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 26,
    fontWeight: FontWeight.w500,
    color: blue,
  ),
  subtitle1: GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: milkWhite,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: milkWhite,
  ),
  bodyText1: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: grey,
  ),
  bodyText2: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: white,
  ),
  button: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: milkWhite,
  ),
  caption: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: darkGrey,
  ),
  overline: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: darkGrey,
  ),
);
