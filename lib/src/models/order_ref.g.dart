// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_ref.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderRef> _$orderRefSerializer = new _$OrderRefSerializer();

class _$OrderRefSerializer implements StructuredSerializer<OrderRef> {
  @override
  final Iterable<Type> types = const [OrderRef, _$OrderRef];
  @override
  final String wireName = 'OrderRef';

  @override
  Iterable<Object> serialize(Serializers serializers, OrderRef object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.totalCost != null) {
      result
        ..add('totalCost')
        ..add(serializers.serialize(object.totalCost,
            specifiedType: const FullType(int)));
    }
    if (object.user != null) {
      result
        ..add('user')
        ..add(serializers.serialize(object.user,
            specifiedType: const FullType(User)));
    }
    if (object.refID != null) {
      result
        ..add('refID')
        ..add(serializers.serialize(object.refID,
            specifiedType: const FullType(String)));
    }
    if (object.deliveryCharge != null) {
      result
        ..add('deliveryCharge')
        ..add(serializers.serialize(object.deliveryCharge,
            specifiedType: const FullType(int)));
    }
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(String)));
    }
    if (object.status != null) {
      result
        ..add('status')
        ..add(serializers.serialize(object.status,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.vendors != null) {
      result
        ..add('vendors')
        ..add(serializers.serialize(object.vendors,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.physicalLocation != null) {
      result
        ..add('physicalLocation')
        ..add(serializers.serialize(object.physicalLocation,
            specifiedType: const FullType(String)));
    }
    if (object.isAssignedTo != null) {
      result
        ..add('isAssignedTo')
        ..add(serializers.serialize(object.isAssignedTo,
            specifiedType: const FullType(User)));
    }
    if (object.lat != null) {
      result
        ..add('lat')
        ..add(serializers.serialize(object.lat,
            specifiedType: const FullType(double)));
    }
    if (object.lang != null) {
      result
        ..add('lang')
        ..add(serializers.serialize(object.lang,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  OrderRef deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderRefBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'totalCost':
          result.totalCost = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'user':
          result.user.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'refID':
          result.refID = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'deliveryCharge':
          result.deliveryCharge = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'vendors':
          result.vendors.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'physicalLocation':
          result.physicalLocation = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isAssignedTo':
          result.isAssignedTo.replace(serializers.deserialize(value,
              specifiedType: const FullType(User)) as User);
          break;
        case 'lat':
          result.lat = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'lang':
          result.lang = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$OrderRef extends OrderRef {
  @override
  final int totalCost;
  @override
  final User user;
  @override
  final String refID;
  @override
  final int deliveryCharge;
  @override
  final String createdAt;
  @override
  final BuiltList<String> status;
  @override
  final BuiltList<String> vendors;
  @override
  final String physicalLocation;
  @override
  final User isAssignedTo;
  @override
  final double lat;
  @override
  final double lang;

  factory _$OrderRef([void Function(OrderRefBuilder) updates]) =>
      (new OrderRefBuilder()..update(updates)).build();

  _$OrderRef._(
      {this.totalCost,
      this.user,
      this.refID,
      this.deliveryCharge,
      this.createdAt,
      this.status,
      this.vendors,
      this.physicalLocation,
      this.isAssignedTo,
      this.lat,
      this.lang})
      : super._();

  @override
  OrderRef rebuild(void Function(OrderRefBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderRefBuilder toBuilder() => new OrderRefBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderRef &&
        totalCost == other.totalCost &&
        user == other.user &&
        refID == other.refID &&
        deliveryCharge == other.deliveryCharge &&
        createdAt == other.createdAt &&
        status == other.status &&
        vendors == other.vendors &&
        physicalLocation == other.physicalLocation &&
        isAssignedTo == other.isAssignedTo &&
        lat == other.lat &&
        lang == other.lang;
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
                                    $jc(
                                        $jc($jc(0, totalCost.hashCode),
                                            user.hashCode),
                                        refID.hashCode),
                                    deliveryCharge.hashCode),
                                createdAt.hashCode),
                            status.hashCode),
                        vendors.hashCode),
                    physicalLocation.hashCode),
                isAssignedTo.hashCode),
            lat.hashCode),
        lang.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrderRef')
          ..add('totalCost', totalCost)
          ..add('user', user)
          ..add('refID', refID)
          ..add('deliveryCharge', deliveryCharge)
          ..add('createdAt', createdAt)
          ..add('status', status)
          ..add('vendors', vendors)
          ..add('physicalLocation', physicalLocation)
          ..add('isAssignedTo', isAssignedTo)
          ..add('lat', lat)
          ..add('lang', lang))
        .toString();
  }
}

class OrderRefBuilder implements Builder<OrderRef, OrderRefBuilder> {
  _$OrderRef _$v;

  int _totalCost;
  int get totalCost => _$this._totalCost;
  set totalCost(int totalCost) => _$this._totalCost = totalCost;

  UserBuilder _user;
  UserBuilder get user => _$this._user ??= new UserBuilder();
  set user(UserBuilder user) => _$this._user = user;

  String _refID;
  String get refID => _$this._refID;
  set refID(String refID) => _$this._refID = refID;

  int _deliveryCharge;
  int get deliveryCharge => _$this._deliveryCharge;
  set deliveryCharge(int deliveryCharge) =>
      _$this._deliveryCharge = deliveryCharge;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  ListBuilder<String> _status;
  ListBuilder<String> get status =>
      _$this._status ??= new ListBuilder<String>();
  set status(ListBuilder<String> status) => _$this._status = status;

  ListBuilder<String> _vendors;
  ListBuilder<String> get vendors =>
      _$this._vendors ??= new ListBuilder<String>();
  set vendors(ListBuilder<String> vendors) => _$this._vendors = vendors;

  String _physicalLocation;
  String get physicalLocation => _$this._physicalLocation;
  set physicalLocation(String physicalLocation) =>
      _$this._physicalLocation = physicalLocation;

  UserBuilder _isAssignedTo;
  UserBuilder get isAssignedTo => _$this._isAssignedTo ??= new UserBuilder();
  set isAssignedTo(UserBuilder isAssignedTo) =>
      _$this._isAssignedTo = isAssignedTo;

  double _lat;
  double get lat => _$this._lat;
  set lat(double lat) => _$this._lat = lat;

  double _lang;
  double get lang => _$this._lang;
  set lang(double lang) => _$this._lang = lang;

  OrderRefBuilder();

  OrderRefBuilder get _$this {
    if (_$v != null) {
      _totalCost = _$v.totalCost;
      _user = _$v.user?.toBuilder();
      _refID = _$v.refID;
      _deliveryCharge = _$v.deliveryCharge;
      _createdAt = _$v.createdAt;
      _status = _$v.status?.toBuilder();
      _vendors = _$v.vendors?.toBuilder();
      _physicalLocation = _$v.physicalLocation;
      _isAssignedTo = _$v.isAssignedTo?.toBuilder();
      _lat = _$v.lat;
      _lang = _$v.lang;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderRef other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OrderRef;
  }

  @override
  void update(void Function(OrderRefBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrderRef build() {
    _$OrderRef _$result;
    try {
      _$result = _$v ??
          new _$OrderRef._(
              totalCost: totalCost,
              user: _user?.build(),
              refID: refID,
              deliveryCharge: deliveryCharge,
              createdAt: createdAt,
              status: _status?.build(),
              vendors: _vendors?.build(),
              physicalLocation: physicalLocation,
              isAssignedTo: _isAssignedTo?.build(),
              lat: lat,
              lang: lang);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'user';
        _user?.build();

        _$failedField = 'status';
        _status?.build();
        _$failedField = 'vendors';
        _vendors?.build();

        _$failedField = 'isAssignedTo';
        _isAssignedTo?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrderRef', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
