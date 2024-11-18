import 'package:equatable/equatable.dart';
import 'package:nhss_reign_forest_cafe/data/models/Order.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderObtained extends OrderState {
  final List<OrderModel> orders;

  OrderObtained({required this.orders});

  @override
  List<Object> get props => [orders];
}

class OrderFailure extends OrderState {
  final String error;

  OrderFailure({required this.error});

  @override
  List<Object> get props => [error];
}
