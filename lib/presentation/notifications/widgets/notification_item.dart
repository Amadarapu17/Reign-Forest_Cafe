import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          color: Color.fromARGB(255, 55, 54, 54),
          width: 342,
          height: 72,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Color.fromARGB(255, 229, 216, 246),
                child: Icon(
                  Icons.notifications_none_sharp,
                  color: Color.fromARGB(255, 151, 71, 255),
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Keval, you placed an order check your email for full details",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.beVietnamPro(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
