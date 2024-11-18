import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Text(
            "Not available at the moment",
            style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 15),
          ),
        ));
  }
}
