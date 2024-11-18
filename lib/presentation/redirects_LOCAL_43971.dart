import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nhss_reign_forest_cafe/data/models/Cart.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';
import 'package:nhss_reign_forest_cafe/data/providers/item_provider.dart';
import 'package:nhss_reign_forest_cafe/data/providers/order_provider.dart';
import 'package:nhss_reign_forest_cafe/data/repositories/item_repository.dart';
import 'package:nhss_reign_forest_cafe/data/repositories/order_repository.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_event.dart';
import 'package:nhss_reign_forest_cafe/logic/order/order_bloc.dart';
import 'package:nhss_reign_forest_cafe/logic/order/order_event.dart';
import 'package:nhss_reign_forest_cafe/presentation/cart/checkout.dart';
import 'package:nhss_reign_forest_cafe/presentation/order/order_search.dart';
import 'package:nhss_reign_forest_cafe/presentation/store/item_info.dart';
import 'package:nhss_reign_forest_cafe/presentation/store/store.dart';
import 'package:nhss_reign_forest_cafe/presentation/cart/cart.dart';

class StoreRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemRepository = new ItemRepository(new ItemProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(itemRepository)..add(GetItems()),
        child: StoreBuild(),
      ),
    );
  }
}

class ItemInfoRedirect extends StatelessWidget {
  final Item item;
  const ItemInfoRedirect({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final itemRepository = new ItemRepository(new ItemProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(itemRepository),
        child: ItemInfo(
          item: item,
        ),
      ),
    );
  }
}

class CartRedirect extends StatelessWidget {
  const CartRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final itemRepository = new ItemRepository(new ItemProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(itemRepository)..add(GetCart()),
        child: CartBuild(),
      ),
    );
  }
}

class CheckoutRedirect extends StatelessWidget {
  final Cart cart;
  final double total;
  const CheckoutRedirect({super.key, required this.cart, required this.total});

  @override
  Widget build(BuildContext context) {
    final itemRepository = new ItemRepository(new ItemProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemBloc>(
        create: (context) => ItemBloc(itemRepository),
        child: Checkout(
          cart: cart,
          total: total,
        ),
      ),
    );
  }
}

class OrderSearchRedirect extends StatelessWidget {
  const OrderSearchRedirect({super.key});

  @override
  Widget build(BuildContext context) {
    final orderRepository = new OrderRepository(new OrderProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<OrderBloc>(
        create: (context) => OrderBloc(orderRepository)..add(GetOrders()),
        child: OrderSearchPageBuild(),
      ),
    );
  }
}
