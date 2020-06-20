import 'package:basketapp/model/Product_Item.dart';
import 'package:mobx/mobx.dart';

part 'Cart_Counter.g.dart';

class Cart_Counter = _Cart_Counter with _$Cart_Counter;

abstract class _Cart_Counter with Store {
  @observable
  Observable itemCounter = Observable(0);

  @observable
  Observable list = Observable(new List<Product_Item>());

  @observable
  ObservableList<Product_Item> cartList = ObservableList<Product_Item>();

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
    final cart = Product_Item(itemId, itemName, imageUrl, description, quantity,
        price, null, null, null, null, null, null, null);
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
