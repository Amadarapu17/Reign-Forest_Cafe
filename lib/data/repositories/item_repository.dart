import 'package:nhss_reign_forest_cafe/data/models/Item.dart';
import 'package:nhss_reign_forest_cafe/data/providers/item_provider.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';

class ItemRepository {
  final ItemProvider _itemProvider;
  ItemRepository(this._itemProvider);

  Future<List<Item>> getItems() async {
    List<Map<String, dynamic>> itemsMetaData = await _itemProvider.getItems();
    List<Map<String, dynamic>> docs = [];
    List<Item> items = [];

    itemsMetaData.map((doc) {
      docs.add(doc);
    }).toList();

    for (Map<String, dynamic> doc in docs) {
      items.add(Item.fromMap(doc));
    }
    return items;
  }

  Future<Cart?> getCart() async {
  Map<String, dynamic>? cartMetaData = await _itemProvider.getCart();
  List<Item> itemMetaData = [];
  
  if (cartMetaData != null) {
    return Cart.fromMap(cartMetaData);
  } else {
    return Cart(items: itemMetaData); 
  }
}


  Future<void> addToCart(Item item) async {
    await _itemProvider.addToCart(item);
  }

  Future<void> addOrder(
    String name,
    String room,
    String email,
    String status,
    Cart cart,
    int style,
    double totalPrice
  ) async {
    print("here");

    await _itemProvider.addOrder(name, room, email, status, cart, style, totalPrice);
  }

  Future<void> removeAllFromCart() async {
    await _itemProvider.removeAllFromCart();
  }

  Future<void> removeItemFromCart() async {
    await _itemProvider.removeItemFromCart();
  }
}
