import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ItemProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getItems() async {
    List<Map<String, dynamic>> itemMetaData = [];
    await firestore.collection("items").get().then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        itemMetaData.add(document.data());
      });
    });

    return itemMetaData;
  }

  Future<void> addToCart(Item item) async {
    var deviceInfo = DeviceInfoPlugin();

    Map<String, dynamic> itemData = new Map<String, dynamic>();
    itemData["title"] = item.title;
    itemData["choices"] = item.choices;
    itemData["choiceSelection"] = item.choiceSelections;
    itemData["price"] = item.price;
    itemData["imageURL"] = item.imageURL;

    var items = [itemData];

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      print(iosDeviceInfo.identifierForVendor);
      print("here");
      await firestore
          .collection("carts")
          .doc(iosDeviceInfo.identifierForVendor)
          .set({
        "id": iosDeviceInfo.identifierForVendor,
        "items": FieldValue.arrayUnion(items),
      }, SetOptions(merge: true));
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      await firestore.collection("carts").doc(androidDeviceInfo.id).update({
        "id": androidDeviceInfo.id,
        "items": FieldValue.arrayUnion(items),
      });
    }
  }

  Future<void> addOrder(
    String name,
    String room,
    String email,
    String status,
    Cart cart,
    int style,
    double totalPrice,
  ) async {
    Map<String, dynamic> orderData = new Map<String, dynamic>();
    orderData["name"] = name;
    orderData["room"] = room;
    orderData["email"] = email;
    orderData["status"] = status;

    if (style == 0) {
      orderData["style"] = "Pickup";
    } else if (style == 1) {
      orderData["style"] = "Delivery";
    }

    Map<String, dynamic> itemMap = new Map<String, dynamic>();

    List<Map<String, dynamic>> itemList = [];

    for (Item item in cart.items) {
      itemMap.addAll(item.toMapDynamic());
      itemList.add(item.toMapDynamic());
    }

    orderData["items"] = itemList;

    await firestore
        .collection("orders")
        .add(orderData)
        .then((documentSnapshot) {
      firestore.collection("orders").doc(documentSnapshot.id).set({
        "orderID": documentSnapshot.id,
      }, SetOptions(merge: true));
    });

    final smtpServer = SmtpServer('smtp.sendgrid.net',
        username: "apikey",
        password:
            "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",
        port: 587);

    final message = Message()
      //..from = Address("vamshipagidi6@gmail.com", 'Vamshi pagidi')
      ..from =
          Address("thenhssreignforestcafe@gmail.com", 'NHSS Reign Forest Cafe')
      ..recipients.add(email)
      ..subject = 'Order Receipt for ' + name
      ..html = """
<html>
  <head>
    <style>
      
      body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
      }
      .header {
        background-color: #9747FF; 
        color: #ffffff;
        padding: 20px;
        text-align: center;
      }
      .content {
        padding: 20px;
      }
      
      table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
      }
      th, td {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 8px;
      }
      th {
        background-color: #f2f2f2;
      }
      
      .total-price {
        font-size: 18px; 
      }
    </style>
  </head>
  <body>
    <div class="header">
      <h1>Your Order has been Successfully Placed!</h1>
    </div>
    <div class="content">
      ${cart.generateItemsTableForEmail()}
      <p class="total-price"><strong>TOTAL PRICE: \$</strong>${totalPrice.toStringAsFixed(2)}</p>
      <img src="https://bigteams-public-prod.s3.amazonaws.com/library/images/nashuahighschoolsouth_bigteams_21550/standard/purplereign.jpg" alt="Purple Reign Image">
    </div>
  </body>
</html>
""";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    print("here3");
  }

  Future<Map<String, dynamic>?> getCart() async {
    var deviceInfo = DeviceInfoPlugin();

    List<Map<String, dynamic>> itemMetaData = [];

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      print(iosDeviceInfo.identifierForVendor);

      DocumentSnapshot<Map<String, dynamic>> doc = await firestore
          .collection("carts")
          .doc(iosDeviceInfo.identifierForVendor)
          .get();

      return doc.data();
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection("carts").doc(androidDeviceInfo.id).get();

      return doc.data();
    }
    return null;
    //return Cart(items: itemMetaData);
  }

  Future<void> removeAllFromCart() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      print(iosDeviceInfo.identifierForVendor);

      await firestore
          .collection("carts")
          .doc(iosDeviceInfo.identifierForVendor)
          .update({"items": []});
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;

      await firestore
          .collection("carts")
          .doc(androidDeviceInfo.id)
          .update({"items": FieldValue.arrayRemove([])});
    }
  }

  Future<void> removeItemFromCart() async {
    var deviceInfo = DeviceInfoPlugin();
    var deviceId;

    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    } else {
      return;
    }

    var cartSnapshot = await firestore.collection("carts").doc(deviceId).get();
    if (cartSnapshot.exists) {
      var cartData = cartSnapshot.data() as Map<String, dynamic>;
      var items = cartData["items"] as List<dynamic>;

      if (items.isNotEmpty) {
        items.removeAt(0);
      }

      await firestore
          .collection("carts")
          .doc(deviceId)
          .update({"items": items});
    }
  }
}
