import 'package:equatable/equatable.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetItems extends ItemEvent {}

class AddToCart extends ItemEvent {
  final Item item;

  AddToCart({required this.item});

  @override
  List<Object> get props => [item];
}

class GetCart extends ItemEvent {}

class AddOrder extends ItemEvent {
  final String name;
  final String room;
  final String email;
  final String status;
  final Cart cart;
  final int style;
  final double totalPrice;

  AddOrder(
      {required this.name,
      required this.room,
      required this.email,
      required this.status,
      required this.cart,
      required this.style,
      required this.totalPrice});
}

class RemoveAllFromCart extends ItemEvent {}

class RemoveItemFromCart extends ItemEvent {}
