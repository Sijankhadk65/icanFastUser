// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liquor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Liquor> _$liquorSerializer = new _$LiquorSerializer();

class _$LiquorSerializer implements StructuredSerializer<Liquor> {
  @override
  final Iterable<Type> types = const [Liquor, _$Liquor];
  @override
  final String wireName = 'Liquor';

  @override
  Iterable<Object> serialize(Serializers serializers, Liquor object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.type != null) {
      result
        ..add('type')
        ..add(serializers.serialize(object.type,
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
    return result;
  }

  @override
  Liquor deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new LiquorBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
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
        case 'isFeatured':
          result.isFeatured = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$Liquor extends Liquor {
  @override
  final String type;
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
  final bool isFeatured;
  @override
  final String description;

  factory _$Liquor([void Function(LiquorBuilder) updates]) =>
      (new LiquorBuilder()..update(updates)).build();

  _$Liquor._(
      {this.type,
      this.createdAt,
      this.name,
      this.photoURI,
      this.price,
      this.isAvailable,
      this.isFeatured,
      this.description})
      : super._();

  @override
  Liquor rebuild(void Function(LiquorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LiquorBuilder toBuilder() => new LiquorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Liquor &&
        type == other.type &&
        createdAt == other.createdAt &&
        name == other.name &&
        photoURI == other.photoURI &&
        price == other.price &&
        isAvailable == other.isAvailable &&
        isFeatured == other.isFeatured &&
        description == other.description;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, type.hashCode), createdAt.hashCode),
                            name.hashCode),
                        photoURI.hashCode),
                    price.hashCode),
                isAvailable.hashCode),
            isFeatured.hashCode),
        description.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Liquor')
          ..add('type', type)
          ..add('createdAt', createdAt)
          ..add('name', name)
          ..add('photoURI', photoURI)
          ..add('price', price)
          ..add('isAvailable', isAvailable)
          ..add('isFeatured', isFeatured)
          ..add('description', description))
        .toString();
  }
}

class LiquorBuilder implements Builder<Liquor, LiquorBuilder> {
  _$Liquor _$v;

  String _type;
  String get type => _$this._type;
  set type(String type) => _$this._type = type;

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

  bool _isFeatured;
  bool get isFeatured => _$this._isFeatured;
  set isFeatured(bool isFeatured) => _$this._isFeatured = isFeatured;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  LiquorBuilder();

  LiquorBuilder get _$this {
    if (_$v != null) {
      _type = _$v.type;
      _createdAt = _$v.createdAt;
      _name = _$v.name;
      _photoURI = _$v.photoURI;
      _price = _$v.price;
      _isAvailable = _$v.isAvailable;
      _isFeatured = _$v.isFeatured;
      _description = _$v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Liquor other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Liquor;
  }

  @override
  void update(void Function(LiquorBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Liquor build() {
    final _$result = _$v ??
        new _$Liquor._(
            type: type,
            createdAt: createdAt,
            name: name,
            photoURI: photoURI,
            price: price,
            isAvailable: isAvailable,
            isFeatured: isFeatured,
            description: description);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
