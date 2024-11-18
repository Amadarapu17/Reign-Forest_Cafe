import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nhss_reign_forest_cafe/presentation/notifications/widgets/notification_item.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    List<NotificationItem> items = [
      NotificationItem(),
      NotificationItem(),
      NotificationItem(),
      NotificationItem(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              "Notifications",
              style: GoogleFonts.beVietnamPro(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          items.length == 0
              ? Column(
                  children: [
                    SizedBox(
                      height: 210,
                    ),
                    Center(
                        child: Column(
                      children: [
                        Image.network("https://i.imgur.com/ghgzxAJ.png"),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "No notifications yet",
                          style: GoogleFonts.beVietnamPro(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                      ],
                    )),
                  ],
                )
              : MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Container(
                    height: 700,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return items[index];
                        }),
                  ),
                ),
        ],
      ),
    );
  }
}
