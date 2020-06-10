// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cart.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Cart on _Cart, Store {
  Computed<ObservableList<ItemProduct>> _$uniProductComputed;

  @override
  ObservableList<ItemProduct> get uniProduct => (_$uniProductComputed ??=
          Computed<ObservableList<ItemProduct>>(() => super.uniProduct,
              name: '_Cart.uniProduct'))
      .value;

  final _$_cartListAtom = Atom(name: '_Cart._cartList');

  @override
  ObservableList<ItemProduct> get _cartList {
    _$_cartListAtom.reportRead();
    return super._cartList;
  }

  @override
  set _cartList(ObservableList<ItemProduct> value) {
    _$_cartListAtom.reportWrite(value, super._cartList, () {
      super._cartList = value;
    });
  }

  final _$_CartActionController = ActionController(name: '_Cart');

  @override
  void addItemToCartList(ItemProduct itemProduct) {
    final _$actionInfo =
        _$_CartActionController.startAction(name: '_Cart.addItemToCartList');
    try {
      return super.addItemToCartList(itemProduct);
    } finally {
      _$_CartActionController.endAction(_$actionInfo);
    }
  }

  @override
  ObservableList<ItemProduct> getCartList() {
    final _$actionInfo =
        _$_CartActionController.startAction(name: '_Cart.getCartList');
    try {
      return super.getCartList();
    } finally {
      _$_CartActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uniProduct: ${uniProduct}
    ''';
  }
}
