// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<MenuItem> _$menuItemSerializer = new _$MenuItemSerializer();

class _$MenuItemSerializer implements StructuredSerializer<MenuItem> {
  @override
  final Iterable<Type> types = const [MenuItem, _$MenuItem];
  @override
  final String wireName = 'MenuItem';

  @override
  Iterable<Object> serialize(Serializers serializers, MenuItem object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.category != null) {
      result
        ..add('category')
        ..add(serializers.serialize(object.category,
            specifiedType: const FullType(String)));
    }
    if (object.name != null) {
      result
        ..add('name')
        ..add(serializers.serialize(object.name,
            specifiedType: const FullType(String)));
    }
    if (object.photoURI != null) {
      result
        ..add('photoURI')
        ..add(serializers.serialize(object.photoURI,
            specifiedType: const FullType(String)));
    }
    if (object.price != null) {
      result
        ..add('price')
        ..add(serializers.serialize(object.price,
            specifiedType: const FullType(int)));
    }
    if (object.isAvailable != null) {
      result
        ..add('isAvailable')
        ..add(serializers.serialize(object.isAvailable,
            specifiedType: const FullType(bool)));
    }
    if (object.isHotAndNew != null) {
      result
        ..add('isHotAndNew')
        ..add(serializers.serialize(object.isHotAndNew,
            specifiedType: const FullType(bool)));
    }
    return result;
  }

  @override
  MenuItem deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new MenuItemBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photoURI':
          result.photoURI = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'isAvailable':
          result.isAvailable = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'isHotAndNew':
          result.isHotAndNew = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$MenuItem extends MenuItem {
  @override
  final String category;
  @override
  final String name;
  @override
  final String photoURI;
  @override
  final int price;
  @override
  final bool isAvailable;
  @override
  final bool isHotAndNew;

  factory _$MenuItem([void Function(MenuItemBuilder) updates]) =>
      (new MenuItemBuilder()..update(updates)).build();

  _$MenuItem._(
      {this.category,
      this.name,
      this.photoURI,
      this.price,
      this.isAvailable,
      this.isHotAndNew})
      : super._();

  @override
  MenuItem rebuild(void Function(MenuItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MenuItemBuilder toBuilder() => new MenuItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MenuItem &&
        category == other.category &&
        name == other.name &&
        photoURI == other.photoURI &&
        price == other.price &&
        isAvailable == other.isAvailable &&
        isHotAndNew == other.isHotAndNew;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, category.hashCode), name.hashCode),
                    photoURI.hashCode),
                price.hashCode),
            isAvailable.hashCode),
        isHotAndNew.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MenuItem')
          ..add('category', category)
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('price', price)
          ..add('isAvailable', isAvailable)
          ..add('isHotAndNew', isHotAndNew))
        .toString();
  }
}

class MenuItemBuilder implements Builder<MenuItem, MenuItemBuilder> {
  _$MenuItem _$v;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _photoURI;
  String get photoURI => _$this._photoURI;
  set photoURI(String photoURI) => _$this._photoURI = photoURI;

  int _price;
  int get price => _$this._price;
  set price(int price) => _$this._price = price;

  bool _isAvailable;
  bool get isAvailable => _$this._isAvailable;
  set isAvailable(bool isAvailable) => _$this._isAvailable = isAvailable;

  bool _isHotAndNew;
  bool get isHotAndNew => _$this._isHotAndNew;
  set isHotAndNew(bool isHotAndNew) => _$this._isHotAndNew = isHotAndNew;

  MenuItemBuilder();

  MenuItemBuilder get _$this {
    if (_$v != null) {
      _category = _$v.category;
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _price = _$v.price;
      _isAvailable = _$v.isAvailable;
      _isHotAndNew = _$v.isHotAndNew;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MenuItem other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MenuItem;
  }

  @override
  void update(void Function(MenuItemBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MenuItem build() {
    final _$result = _$v ??
        new _$MenuItem._(
            category: category,
            name: name,
            photoURI: photoURI,
            price: price,
            isAvailable: isAvailable,
            isHotAndNew: isHotAndNew);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
