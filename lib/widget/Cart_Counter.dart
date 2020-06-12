import 'package:basketapp/widget/Cart_List.dart';
import 'package:mobx/mobx.dart';

part 'Cart_Counter.g.dart';

class Cart_Counter = _Cart_Counter with _$Cart_Counter;

abstract class _Cart_Counter with Store {
  @observable
  Observable itemCounter = Observable(0);

  @observable
  Observable list = Observable(new List<Cart_Order>());

  @observable
  ObservableList<Cart_Order> cartList = ObservableList<Cart_Order>();

  //String x = Observable("Test");

  @action
  void increment() {
    itemCounter.value++;
    //dispose();
  }

  @action
  void decrement() {
    itemCounter.value--;
    //dispose();
  }

  @action
  void addCartItemToBusket(String itemId, String itemName, String imageUrl,
      String description, String quantity, String price) {
    final cart =
        Cart_Order(itemId, itemName, imageUrl, description, quantity, price);
    cartList.add(cart);
    //list.value
  }

  @action
  void clearBusketCart() {
    cartList.clear();
  }

  static final greeting = Observable('Hello World');

  final dispose = autorun((_) {
    print(greeting.value);
  });
}
