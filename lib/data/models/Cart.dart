import 'package:nhss_reign_forest_cafe/data/models/Item.dart';

class Cart {
  final List<Item> items;

  Cart({required this.items});

  factory Cart.fromMap(Map<String, dynamic> snapshot) {
    List<dynamic> snapshotItems = snapshot["items"];
    List<Item> tempItems = [];

    for (var snapshotItem in snapshotItems) {
      tempItems.add(Item.fromMap(snapshotItem));
    }

    return Cart(
      items: tempItems,
    );
  }

  String generateItemsTableForEmail() {
    String table = '<table>';
    table += '<tr>';
    table += '<th>Image</th>';
    table += '<th>Item</th>';
    table += '<th>Quantity</th>';
    table += '</tr>';

    for (Item item in items) {
      int totalQuantity = 0;
      for (int choiceSelection in item.choiceSelections) {
        totalQuantity += choiceSelection;
      }

      if (totalQuantity > 0) {
        table += '<tr>';
        table +=
            '<td><img src="${item.imageURL}" alt="${item.title} Image" style="max-width: 100px; height: auto;"></td>';
        table += '<td>${item.title}</td>';
        table += '<td>${totalQuantity}</td>';
        table += '</tr>';
      }
    }

    table += '</table>';
    return table;
  }
}
