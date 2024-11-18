
class OrderModel {
  final List<String> items;
  final String name;
  final String room;
  //final String time;
  final String orderID;
  final String status;
  final String style;

  OrderModel(
      {required this.items,
      required this.name,
      required this.room,
      //required this.time,
      required this.orderID,
      required this.status,
      required this.style});

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    print(map["items"]);
    List<dynamic> items = map["items"] ?? [];
    return OrderModel(
        items: items.cast<String>(),
        name: map["name"] ?? '',
        room: map["room"] ?? '',
        //time: map["time"] ?? '',
        orderID: map["orderID"] ?? '',
        status: map["status"] ?? '',
        style: map["style"] ?? '');
  }
}
