import 'package:flutter/material.dart';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 342,
      height: 72,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Color.fromARGB(255, 229, 216, 246),
            child: Icon(
              Icons.fastfood_outlined,
              color: Color.fromARGB(255, 151, 71, 255),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${order.name}'s Order",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Text(
                  "${order.items.length} item(s)",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.beVietnamPro(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 90),
          Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
