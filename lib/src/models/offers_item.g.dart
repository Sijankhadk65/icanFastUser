// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offers_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OffersItem> _$offersItemSerializer = new _$OffersItemSerializer();

class _$OffersItemSerializer implements StructuredSerializer<OffersItem> {
  @override
  final Iterable<Type> types = const [OffersItem, _$OffersItem];
  @override
  final String wireName = 'OffersItem';

  @override
  Iterable<Object> serialize(Serializers serializers, OffersItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(String)));
    }
    if (object.isActive != null) {
      result
        ..add('isActive')
        ..add(serializers.serialize(object.isActive,
            specifiedType: const FullType(bool)));
    }
    if (object.photoURI != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(object.photoURI,
            specifiedType: const FullType(String)));
    }
    if (object.vendor != null) {
      result
        ..add('vendor')
        ..add(serializers.serialize(object.vendor,
            specifiedType: const FullType(String)));
    }
    if (object.price != null) {
      result
        ..add('price')
        ..add(serializers.serialize(object.price,
            specifiedType: const FullType(int)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  OffersItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OffersItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'isActive':
          result.isActive = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor':
          result.vendor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$OffersItem extends OffersItem {
  @override
  final String createdAt;
  @override
  final bool isActive;
  @override
  final String photoURI;
  @override
  final String vendor;
  @override
  final int price;
  @override
  final String description;
  @override
  final String name;

  factory _$OffersItem([void Function(OffersItemBuilder) updates]) =>
      (new OffersItemBuilder()..update(updates)).build();

  _$OffersItem._(
      {this.createdAt,
      this.isActive,
      this.photoURI,
      this.vendor,
      this.price,
      this.description,
      this.name})
      : super._();

  @override
  OffersItem rebuild(void Function(OffersItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OffersItemBuilder toBuilder() => new OffersItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OffersItem &&
        createdAt == other.createdAt &&
        isActive == other.isActive &&
        photoURI == other.photoURI &&
        vendor == other.vendor &&
        price == other.price &&
        description == other.description &&
        name == other.name;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, createdAt.hashCode), isActive.hashCode),
                        photoURI.hashCode),
                    vendor.hashCode),
                price.hashCode),
            description.hashCode),
        name.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OffersItem')
          ..add('createdAt', createdAt)
          ..add('isActive', isActive)
          ..add('photoURI', photoURI)
          ..add('vendor', vendor)
          ..add('price', price)
          ..add('description', description)
          ..add('name', name))
        .toString();
  }
}

class OffersItemBuilder implements Builder<OffersItem, OffersItemBuilder> {
  _$OffersItem _$v;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  bool _isActive;
  bool get isActive => _$this._isActive;
  set isActive(bool isActive) => _$this._isActive = isActive;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  String _vendor;
  String get vendor => _$this._vendor;
  set vendor(String vendor) => _$this._vendor = vendor;

  int _price;
  int get price => _$this._price;
  set price(int price) => _$this._price = price;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  OffersItemBuilder();

  OffersItemBuilder get _$this {
    if (_$v != null) {
      _createdAt = _$v.createdAt;
      _isActive = _$v.isActive;
      _photoURI = _$v.photoURI;
      _vendor = _$v.vendor;
      _price = _$v.price;
      _description = _$v.description;
      _name = _$v.name;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OffersItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OffersItem;
  }

  @override
  void update(void Function(OffersItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OffersItem build() {
    final _$result = _$v ??
        new _$OffersItem._(
            createdAt: createdAt,
            isActive: isActive,
            photoURI: photoURI,
            vendor: vendor,
            price: price,
            description: description,
            name: name);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
