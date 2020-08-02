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
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
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
    if (object.isFeatured != null) {
      result
        ..add('isFeatured')
        ..add(serializers.serialize(object.isFeatured,
            specifiedType: const FullType(bool)));
    }
    if (object.description != null) {
      result
        ..add('description')
        ..add(serializers.serialize(object.description,
            specifiedType: const FullType(String)));
    }
    if (object.vendor != null) {
      result
        ..add('vendor')
        ..add(serializers.serialize(object.vendor,
            specifiedType: const FullType(String)));
    }
    if (object.addOn != null) {
      result
        ..add('addOn')
        ..add(serializers.serialize(object.addOn,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
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
        case 'isFeatured':
          result.isFeatured = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendor':
          result.vendor = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'addOn':
          result.addOn.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
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
  final String createdAt;
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
  @override
  final bool isFeatured;
  @override
  final String description;
  @override
  final String vendor;
  @override
  final BuiltList<String> addOn;

  factory _$MenuItem([void Function(MenuItemBuilder) updates]) =>
      (new MenuItemBuilder()..update(updates)).build();

  _$MenuItem._(
      {this.category,
      this.createdAt,
      this.name,
      this.photoURI,
      this.price,
      this.isAvailable,
      this.isHotAndNew,
      this.isFeatured,
      this.description,
      this.vendor,
      this.addOn})
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
        createdAt == other.createdAt &&
        name == other.name &&
        photoURI == other.photoURI &&
        price == other.price &&
        isAvailable == other.isAvailable &&
        isHotAndNew == other.isHotAndNew &&
        isFeatured == other.isFeatured &&
        description == other.description &&
        vendor == other.vendor &&
        addOn == other.addOn;
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
                                        $jc($jc(0, category.hashCode),
                                            createdAt.hashCode),
                                        name.hashCode),
                                    photoURI.hashCode),
                                price.hashCode),
                            isAvailable.hashCode),
                        isHotAndNew.hashCode),
                    isFeatured.hashCode),
                description.hashCode),
            vendor.hashCode),
        addOn.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MenuItem')
          ..add('category', category)
          ..add('createdAt', createdAt)
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('price', price)
          ..add('isAvailable', isAvailable)
          ..add('isHotAndNew', isHotAndNew)
          ..add('isFeatured', isFeatured)
          ..add('description', description)
          ..add('vendor', vendor)
          ..add('addOn', addOn))
        .toString();
  }
}

class MenuItemBuilder implements Builder<MenuItem, MenuItemBuilder> {
  _$MenuItem _$v;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

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

  bool _isFeatured;
  bool get isFeatured => _$this._isFeatured;
  set isFeatured(bool isFeatured) => _$this._isFeatured = isFeatured;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _vendor;
  String get vendor => _$this._vendor;
  set vendor(String vendor) => _$this._vendor = vendor;

  ListBuilder<String> _addOn;
  ListBuilder<String> get addOn => _$this._addOn ??= new ListBuilder<String>();
  set addOn(ListBuilder<String> addOn) => _$this._addOn = addOn;

  MenuItemBuilder();

  MenuItemBuilder get _$this {
    if (_$v != null) {
      _category = _$v.category;
      _createdAt = _$v.createdAt;
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _price = _$v.price;
      _isAvailable = _$v.isAvailable;
      _isHotAndNew = _$v.isHotAndNew;
      _isFeatured = _$v.isFeatured;
      _description = _$v.description;
      _vendor = _$v.vendor;
      _addOn = _$v.addOn?.toBuilder();
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
    _$MenuItem _$result;
    try {
      _$result = _$v ??
          new _$MenuItem._(
              category: category,
              createdAt: createdAt,
              name: name,
              photoURI: photoURI,
              price: price,
              isAvailable: isAvailable,
              isHotAndNew: isHotAndNew,
              isFeatured: isFeatured,
              description: description,
              vendor: vendor,
              addOn: _addOn?.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'addOn';
        _addOn?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'MenuItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
