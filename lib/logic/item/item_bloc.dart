import 'package:bloc/bloc.dart';
import 'package:nhss_reign_forest_cafe/data/models/Item.dart';
import 'package:nhss_reign_forest_cafe/data/repositories/item_repository.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_event.dart';
import 'package:nhss_reign_forest_cafe/logic/item/item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository _itemRepository;

  ItemBloc(ItemRepository itemRepository)
      : _itemRepository = itemRepository,
        super(PostInitial());

  @override
  Stream<ItemState> mapEventToState(ItemEvent event) async* {
    if (event is RemoveAllFromCart) {
      _itemRepository.removeAllFromCart();
    }
    if (event is RemoveItemFromCart) {
      _itemRepository.removeItemFromCart();
    }
    if (event is GetItems) {
      yield* _mapGetItemsToState(event);
    }

    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    }

    if (event is GetCart) {
      yield* _mapGetCartToState(event);
    }

    if (event is AddOrder) {
      yield* _mapAddOrderToState(event);
    }
  }

  Stream<ItemState> _mapGetItemsToState(GetItems event) async* {
    yield ItemLoading();
    final items = await _itemRepository.getItems();

    yield ItemsObtained(items: items);
    }

  Stream<ItemState> _mapAddToCartToState(AddToCart event) async* {
    yield ItemLoading();
    await _itemRepository.addToCart(event.item);
    yield AddedToCart();
  }

  Stream<ItemState> _mapGetCartToState(GetCart event) async* {
    yield ItemLoading();
    final cart = await _itemRepository.getCart();

    double total = 0;
    for (Item i in cart!.items) {
      int totalChoices = 0;
      for (int choices in i.choiceSelections) {
        totalChoices = totalChoices + choices;
      }

      print("Total Choices is " + totalChoices.toString());
      if (totalChoices != 0) {
        total = total + (i.price * totalChoices);
      } else {
        total = total + i.price;
      }
    }
    yield CartObtained(cart: cart, totalPrice: total);
    }

  Stream<ItemState> _mapAddOrderToState(AddOrder event) async* {
    yield ItemLoading();
    await _itemRepository.addOrder(
        event.name, event.room, event.email, event.status, event.cart, event.style, event.totalPrice);
    yield AddedOrder();
  }
}
