import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class OnflyTypography {
  // Headings
  static TextStyle get titleXL => GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static TextStyle get titleLG => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static TextStyle get titleMD => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  static TextStyle get titleSM => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    height: 1.3,
  );

  // Body Text
  static TextStyle get bodyLG => GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodyMD => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  static TextStyle get bodySM => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    height: 1.5,
  );

  // Subtitles
  static TextStyle get subtitleMD => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.2,
  );

  static TextStyle get subtitleSM => GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.2,
  );

  // Labels
  static TextStyle get label => GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );
}
