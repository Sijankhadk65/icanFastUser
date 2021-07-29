// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_on.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AddOn> _$addOnSerializer = new _$AddOnSerializer();

class _$AddOnSerializer implements StructuredSerializer<AddOn> {
  @override
  final Iterable<Type> types = const [AddOn, _$AddOn];
  @override
  final String wireName = 'AddOn';

  @override
  Iterable<Object> serialize(Serializers serializers, AddOn object,
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
            specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  AddOn deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AddOnBuilder();

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
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$AddOn extends AddOn {
  @override
  final String name;
  @override
  final int price;

  factory _$AddOn([void Function(AddOnBuilder) updates]) =>
      (new AddOnBuilder()..update(updates)).build();

  _$AddOn._({this.name, this.price}) : super._();

  @override
  AddOn rebuild(void Function(AddOnBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddOnBuilder toBuilder() => new AddOnBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddOn && name == other.name && price == other.price;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), price.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AddOn')
          ..add('name', name)
          ..add('price', price))
        .toString();
  }
}

class AddOnBuilder implements Builder<AddOn, AddOnBuilder> {
  _$AddOn _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _price;
  int get price => _$this._price;
  set price(int price) => _$this._price = price;

  AddOnBuilder();

  AddOnBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _price = _$v.price;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddOn other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AddOn;
  }

  @override
  void update(void Function(AddOnBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AddOn build() {
    final _$result = _$v ?? new _$AddOn._(name: name, price: price);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
