import 'package:equatable/equatable.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';

abstract class ItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemsObtained extends ItemState {
  final List<Item> items;

  ItemsObtained({required this.items});

  @override
  List<Object> get props => [items];
}

class AddedToCart extends ItemState {}

class AddedOrder extends ItemState {}

class CartObtained extends ItemState {
  final Cart cart;
  final double totalPrice;

  CartObtained({required this.cart, required this.totalPrice});

  @override
  List<Object> get props => [cart];
}

class ItemFailure extends ItemState {
  final String error;

  ItemFailure({required this.error});

  @override
  List<Object> get props => [error];
}
