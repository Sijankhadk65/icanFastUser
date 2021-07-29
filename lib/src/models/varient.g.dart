// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'varient.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Varient> _$varientSerializer = new _$VarientSerializer();

class _$VarientSerializer implements StructuredSerializer<Varient> {
  @override
  final Iterable<Type> types = const [Varient, _$Varient];
  @override
  final String wireName = 'Varient';

  @override
  Iterable<Object> serialize(Serializers serializers, Varient object,
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
  Varient deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new VarientBuilder();

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

class _$Varient extends Varient {
  @override
  final String name;
  @override
  final int price;

  factory _$Varient([void Function(VarientBuilder) updates]) =>
      (new VarientBuilder()..update(updates)).build();

  _$Varient._({this.name, this.price}) : super._();

  @override
  Varient rebuild(void Function(VarientBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VarientBuilder toBuilder() => new VarientBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Varient && name == other.name && price == other.price;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), price.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Varient')
          ..add('name', name)
          ..add('price', price))
        .toString();
  }
}

class VarientBuilder implements Builder<Varient, VarientBuilder> {
  _$Varient _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  int _price;
  int get price => _$this._price;
  set price(int price) => _$this._price = price;

  VarientBuilder();

  VarientBuilder get _$this {
    if (_$v != null) {
      _name = _$v.name;
      _price = _$v.price;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Varient other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Varient;
  }

  @override
  void update(void Function(VarientBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Varient build() {
    final _$result = _$v ?? new _$Varient._(name: name, price: price);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
