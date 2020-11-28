import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import './item.dart';

import './serializer.dart';

part 'cart_items.g.dart';

abstract class CartItem implements Built<CartItem, CartItemBuilder> {
  @nullable
  String get name;
  @nullable
  int get price;
  @nullable
  int get totalPrice;
  @nullable
  int get quantity;
  @nullable
  String get photoURI;
  CartItem._();
  factory CartItem([updates(CartItemBuilder b)]) = _$CartItem;
  static Serializer<CartItem> get serializer => _$cartItemSerializer;
  Map<String, dynamic> toJson() => {
        "name": this.name,
        "price": this.price,
        "quantity": this.quantity,
        "totalPrice": this.totalPrice,
        "photoURI": this.photoURI,
      };
}

CartItem parseToCartItem(Map<String, dynamic> json) {
  return jsonSerializer.deserializeWith(CartItem.serializer, json);
}

CartItem newFromItemModel(MenuItem item) {
  var itemJson = item.toNewMenuItemJson();
  return jsonSerializer.deserializeWith(CartItem.serializer, itemJson);
}
