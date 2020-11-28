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
            specifiedType: const FullType(double)));
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
            specifiedType: const FullType(double)));
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
    if (object.vendorName != null) {
      result
        ..add('vendorName')
        ..add(serializers.serialize(object.vendorName,
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
    if (object.promoCodes != null) {
      result
        ..add('promoCodes')
        ..add(serializers.serialize(object.promoCodes,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
              specifiedType: const FullType(double)) as double;
          break;
        case 'refID':
          result.refID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'cartLength':
          result.cartLength = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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
        case 'vendorName':
          result.vendorName = serializers.deserialize(value,
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
        case 'promoCodes':
          result.promoCodes.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
      }
    }

    return result.build();
  }
}

class _$OnlineOrder extends OnlineOrder {
  @override
  final double totalPrice;
  @override
  final String refID;
  @override
  final double cartLength;
  @override
  final BuiltList<String> status;
  @override
  final String createdAt;
  @override
  final String vendor;
  @override
  final String vendorName;
  @override
  final int minOrder;
  @override
  final BuiltList<CartItem> items;
  @override
  final BuiltList<String> promoCodes;

  factory _$OnlineOrder([void Function(OnlineOrderBuilder) updates]) =>
      (new OnlineOrderBuilder()..update(updates)).build();

  _$OnlineOrder._(
      {this.totalPrice,
      this.refID,
      this.cartLength,
      this.status,
      this.createdAt,
      this.vendor,
      this.vendorName,
      this.minOrder,
      this.items,
      this.promoCodes})
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
        vendorName == other.vendorName &&
        minOrder == other.minOrder &&
        items == other.items &&
        promoCodes == other.promoCodes;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, totalPrice.hashCode),
                                        refID.hashCode),
                                    cartLength.hashCode),
                                status.hashCode),
                            createdAt.hashCode),
                        vendor.hashCode),
                    vendorName.hashCode),
                minOrder.hashCode),
            items.hashCode),
        promoCodes.hashCode));
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
          ..add('vendorName', vendorName)
          ..add('minOrder', minOrder)
          ..add('items', items)
          ..add('promoCodes', promoCodes))
        .toString();
  }
}

class OnlineOrderBuilder implements Builder<OnlineOrder, OnlineOrderBuilder> {
  _$OnlineOrder _$v;

  double _totalPrice;
  double get totalPrice => _$this._totalPrice;
  set totalPrice(double totalPrice) => _$this._totalPrice = totalPrice;

  String _refID;
  String get refID => _$this._refID;
  set refID(String refID) => _$this._refID = refID;

  double _cartLength;
  double get cartLength => _$this._cartLength;
  set cartLength(double cartLength) => _$this._cartLength = cartLength;

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

  String _vendorName;
  String get vendorName => _$this._vendorName;
  set vendorName(String vendorName) => _$this._vendorName = vendorName;

  int _minOrder;
  int get minOrder => _$this._minOrder;
  set minOrder(int minOrder) => _$this._minOrder = minOrder;

  ListBuilder<CartItem> _items;
  ListBuilder<CartItem> get items =>
      _$this._items ??= new ListBuilder<CartItem>();
  set items(ListBuilder<CartItem> items) => _$this._items = items;

  ListBuilder<String> _promoCodes;
  ListBuilder<String> get promoCodes =>
      _$this._promoCodes ??= new ListBuilder<String>();
  set promoCodes(ListBuilder<String> promoCodes) =>
      _$this._promoCodes = promoCodes;

  OnlineOrderBuilder();

  OnlineOrderBuilder get _$this {
    if (_$v != null) {
      _totalPrice = _$v.totalPrice;
      _refID = _$v.refID;
      _cartLength = _$v.cartLength;
      _status = _$v.status?.toBuilder();
      _createdAt = _$v.createdAt;
      _vendor = _$v.vendor;
      _vendorName = _$v.vendorName;
      _minOrder = _$v.minOrder;
      _items = _$v.items?.toBuilder();
      _promoCodes = _$v.promoCodes?.toBuilder();
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
              vendorName: vendorName,
              minOrder: minOrder,
              items: _items?.build(),
              promoCodes: _promoCodes?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'status';
        _status?.build();

        _$failedField = 'items';
        _items?.build();
        _$failedField = 'promoCodes';
        _promoCodes?.build();
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
