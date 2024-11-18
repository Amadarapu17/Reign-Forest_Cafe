import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';

class OrderProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get orderStream => firestore.collection("orders").snapshots();

  Future<List<Map<String, dynamic>>> getOrders() async {
    List<Map<String, dynamic>> orderMetaData = [];
    await firestore.collection("orders").get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        orderMetaData.add(doc.data());
      });
    });

    return orderMetaData;
  }
  
  

Future<OrderModel?> getOrderById(String orderId) async {
  DocumentSnapshot orderSnapshot =
      await firestore.collection("orders").doc(orderId).get();

  if (orderSnapshot.exists) {
    return OrderModel.fromMap(orderSnapshot.data() as Map<String, dynamic>);
  } else {
    return null;
  }
}



}
