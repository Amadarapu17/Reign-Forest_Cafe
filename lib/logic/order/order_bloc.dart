import 'package:bloc/bloc.dart';
import 'package:nhss_reign_forest_cafe/data/repositories/order_repository.dart';
import 'order_event.dart';
import 'order_state.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc(OrderRepository orderRepository)
      : _orderRepository = orderRepository,
        super(OrderInitial());

  @override
  Stream<OrderState> mapEventToState(OrderEvent event) async* {
    if (event is GetOrders) {
      yield* _mapGetOrdersToState(event);
    }
  }

  Stream<OrderState> _mapGetOrdersToState(GetOrders event) async* {
    yield OrderLoading();
    final orders = await _orderRepository.getOrders();
    print(orders);
    yield OrderObtained(orders: orders);
    }
}
