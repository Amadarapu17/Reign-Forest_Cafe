import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class PreviousOrders extends StatelessWidget {
  const PreviousOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              "Previous Orders",
              style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}