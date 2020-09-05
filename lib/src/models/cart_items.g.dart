// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_items.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CartItem> _$cartItemSerializer = new _$CartItemSerializer();

class _$CartItemSerializer implements StructuredSerializer<CartItem> {
  @override
  final Iterable<Type> types = const [CartItem, _$CartItem];
  @override
  final String wireName = 'CartItem';

  @override
  Iterable<Object> serialize(Serializers serializers, CartItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.price != null) {
      result
        ..add('price')
        ..add(serializers.serialize(object.price,
            specifiedType: const FullType(double)));
    }
    if (object.totalPrice != null) {
      result
        ..add('totalPrice')
        ..add(serializers.serialize(object.totalPrice,
            specifiedType: const FullType(double)));
    }
    if (object.quantity != null) {
      result
        ..add('quantity')
        ..add(serializers.serialize(object.quantity,
            specifiedType: const FullType(double)));
    }
    if (object.photoURI != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(object.photoURI,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  CartItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CartItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'totalPrice':
          result.totalPrice = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$CartItem extends CartItem {
  @override
  final String name;
  @override
  final double price;
  @override
  final double totalPrice;
  @override
  final double quantity;
  @override
  final String photoURI;

  factory _$CartItem([void Function(CartItemBuilder) updates]) =>
      (new CartItemBuilder()..update(updates)).build();

  _$CartItem._(
      {this.name, this.price, this.totalPrice, this.quantity, this.photoURI})
      : super._();

  @override
  CartItem rebuild(void Function(CartItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CartItemBuilder toBuilder() => new CartItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CartItem &&
        name == other.name &&
        price == other.price &&
        totalPrice == other.totalPrice &&
        quantity == other.quantity &&
        photoURI == other.photoURI;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, name.hashCode), price.hashCode),
                totalPrice.hashCode),
            quantity.hashCode),
        photoURI.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CartItem')
          ..add('name', name)
          ..add('price', price)
          ..add('totalPrice', totalPrice)
          ..add('quantity', quantity)
          ..add('photoURI', photoURI))
        .toString();
  }
}

class CartItemBuilder implements Builder<CartItem, CartItemBuilder> {
  _$CartItem _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  double _totalPrice;
  double get totalPrice => _$this._totalPrice;
  set totalPrice(double totalPrice) => _$this._totalPrice = totalPrice;

  double _quantity;
  double get quantity => _$this._quantity;
  set quantity(double quantity) => _$this._quantity = quantity;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  CartItemBuilder();

  CartItemBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _price = _$v.price;
      _totalPrice = _$v.totalPrice;
      _quantity = _$v.quantity;
      _photoURI = _$v.photoURI;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CartItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CartItem;
  }

  @override
  void update(void Function(CartItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CartItem build() {
    final _$result = _$v ??
        new _$CartItem._(
            name: name,
            price: price,
            totalPrice: totalPrice,
            quantity: quantity,
            photoURI: photoURI);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
