// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OnlineOrder> _$onlineOrderSerializer = new _$OnlineOrderSerializer();

class _$OnlineOrderSerializer implements StructuredSerializer<OnlineOrder> {
  @override
  final Iterable<Type> types = const [OnlineOrder, _$OnlineOrder];
  @override
  final String wireName = 'OnlineOrder';

  @override
  Iterable<Object> serialize(Serializers serializers, OnlineOrder object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.totalPrice != null) {
      result
        ..add('totalPrice')
        ..add(serializers.serialize(object.totalPrice,
            specifiedType: const FullType(int)));
    }
    if (object.refID != null) {
      result
        ..add('refID')
        ..add(serializers.serialize(object.refID,
            specifiedType: const FullType(String)));
    }
    if (object.cartLength != null) {
      result
        ..add('cartLength')
        ..add(serializers.serialize(object.cartLength,
            specifiedType: const FullType(int)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(String)));
    }
    if (object.vendor != null) {
      result
        ..add('vendor')
        ..add(serializers.serialize(object.vendor,
            specifiedType: const FullType(String)));
    }
    if (object.minOrder != null) {
      result
        ..add('minOrder')
        ..add(serializers.serialize(object.minOrder,
            specifiedType: const FullType(int)));
    }
    if (object.items != null) {
      result
        ..add('items')
        ..add(serializers.serialize(object.items,
            specifiedType:
                const FullType(BuiltList, const [const FullType(CartItem)])));
    }
    return result;
  }

  @override
  OnlineOrder deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OnlineOrderBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'totalPrice':
          result.totalPrice = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'refID':
          result.refID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cartLength':
          result.cartLength = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'status':
          result.status.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor':
          result.vendor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'minOrder':
          result.minOrder = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CartItem)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$OnlineOrder extends OnlineOrder {
  @override
  final int totalPrice;
  @override
  final String refID;
  @override
  final int cartLength;
  @override
  final BuiltList<String> status;
  @override
  final String createdAt;
  @override
  final String vendor;
  @override
  final int minOrder;
  @override
  final BuiltList<CartItem> items;

  factory _$OnlineOrder([void Function(OnlineOrderBuilder) updates]) =>
      (new OnlineOrderBuilder()..update(updates)).build();

  _$OnlineOrder._(
      {this.totalPrice,
      this.refID,
      this.cartLength,
      this.status,
      this.createdAt,
      this.vendor,
      this.minOrder,
      this.items})
      : super._();

  @override
  OnlineOrder rebuild(void Function(OnlineOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OnlineOrderBuilder toBuilder() => new OnlineOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OnlineOrder &&
        totalPrice == other.totalPrice &&
        refID == other.refID &&
        cartLength == other.cartLength &&
        status == other.status &&
        createdAt == other.createdAt &&
        vendor == other.vendor &&
        minOrder == other.minOrder &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, totalPrice.hashCode), refID.hashCode),
                            cartLength.hashCode),
                        status.hashCode),
                    createdAt.hashCode),
                vendor.hashCode),
            minOrder.hashCode),
        items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OnlineOrder')
          ..add('totalPrice', totalPrice)
          ..add('refID', refID)
          ..add('cartLength', cartLength)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('vendor', vendor)
          ..add('minOrder', minOrder)
          ..add('items', items))
        .toString();
  }
}

class OnlineOrderBuilder implements Builder<OnlineOrder, OnlineOrderBuilder> {
  _$OnlineOrder _$v;

  int _totalPrice;
  int get totalPrice => _$this._totalPrice;
  set totalPrice(int totalPrice) => _$this._totalPrice = totalPrice;

  String _refID;
  String get refID => _$this._refID;
  set refID(String refID) => _$this._refID = refID;

  int _cartLength;
  int get cartLength => _$this._cartLength;
  set cartLength(int cartLength) => _$this._cartLength = cartLength;

  ListBuilder<String> _status;
  ListBuilder<String> get status =>
      _$this._status ??= new ListBuilder<String>();
  set status(ListBuilder<String> status) => _$this._status = status;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  String _vendor;
  String get vendor => _$this._vendor;
  set vendor(String vendor) => _$this._vendor = vendor;

  int _minOrder;
  int get minOrder => _$this._minOrder;
  set minOrder(int minOrder) => _$this._minOrder = minOrder;

  ListBuilder<CartItem> _items;
  ListBuilder<CartItem> get items =>
      _$this._items ??= new ListBuilder<CartItem>();
  set items(ListBuilder<CartItem> items) => _$this._items = items;

  OnlineOrderBuilder();

  OnlineOrderBuilder get _$this {
    if (_$v != null) {
      _totalPrice = _$v.totalPrice;
      _refID = _$v.refID;
      _cartLength = _$v.cartLength;
      _status = _$v.status?.toBuilder();
      _createdAt = _$v.createdAt;
      _vendor = _$v.vendor;
      _minOrder = _$v.minOrder;
      _items = _$v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OnlineOrder other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OnlineOrder;
  }

  @override
  void update(void Function(OnlineOrderBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OnlineOrder build() {
    _$OnlineOrder _$result;
    try {
      _$result = _$v ??
          new _$OnlineOrder._(
              totalPrice: totalPrice,
              refID: refID,
              cartLength: cartLength,
              status: _status?.build(),
              createdAt: createdAt,
              vendor: vendor,
              minOrder: minOrder,
              items: _items?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'status';
        _status?.build();

        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OnlineOrder', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
