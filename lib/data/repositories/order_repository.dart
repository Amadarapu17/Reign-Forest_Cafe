import 'dart:async';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';
import '../providers/order_provider.dart';

class OrderRepository {
  final OrderProvider _orderProvider;

  OrderRepository(this._orderProvider);

  Future<List<OrderModel>> getOrders() async {
    List<Map<String, dynamic>> orderMetaData = await _orderProvider.getOrders();
    List<Map<String, dynamic>> docs = [];
    List<OrderModel> orders = [];

    orderMetaData.map((doc) {
      docs.add(doc);
    }).toList();

    for (Map<String, dynamic> doc in docs) {
      orders.add(OrderModel.fromMap(doc));
    }

    return orders;
  }
}
