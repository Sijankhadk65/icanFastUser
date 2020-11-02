// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo_code.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<PromoCode> _$promoCodeSerializer = new _$PromoCodeSerializer();

class _$PromoCodeSerializer implements StructuredSerializer<PromoCode> {
  @override
  final Iterable<Type> types = const [PromoCode, _$PromoCode];
  @override
  final String wireName = 'PromoCode';

  @override
  Iterable<Object> serialize(Serializers serializers, PromoCode object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    if (object.validTill != null) {
      result
        ..add('validTill')
        ..add(serializers.serialize(object.validTill,
            specifiedType: const FullType(String)));
    }
    if (object.vendors != null) {
      result
        ..add('vendors')
        ..add(serializers.serialize(object.vendors,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    if (object.rate != null) {
      result
        ..add('rate')
        ..add(serializers.serialize(object.rate,
            specifiedType: const FullType(double)));
    }
    if (object.createdAt != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(object.createdAt,
            specifiedType: const FullType(String)));
    }
    if (object.code != null) {
      result
        ..add('code')
        ..add(serializers.serialize(object.code,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  PromoCode deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PromoCodeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'validTill':
          result.validTill = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vendors':
          result.vendors.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<dynamic>);
          break;
        case 'rate':
          result.rate = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$PromoCode extends PromoCode {
  @override
  final String validTill;
  @override
  final BuiltList<String> vendors;
  @override
  final double rate;
  @override
  final String createdAt;
  @override
  final String code;

  factory _$PromoCode([void Function(PromoCodeBuilder) updates]) =>
      (new PromoCodeBuilder()..update(updates)).build();

  _$PromoCode._(
      {this.validTill, this.vendors, this.rate, this.createdAt, this.code})
      : super._();

  @override
  PromoCode rebuild(void Function(PromoCodeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PromoCodeBuilder toBuilder() => new PromoCodeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PromoCode &&
        validTill == other.validTill &&
        vendors == other.vendors &&
        rate == other.rate &&
        createdAt == other.createdAt &&
        code == other.code;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, validTill.hashCode), vendors.hashCode),
                rate.hashCode),
            createdAt.hashCode),
        code.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('PromoCode')
          ..add('validTill', validTill)
          ..add('vendors', vendors)
          ..add('rate', rate)
          ..add('createdAt', createdAt)
          ..add('code', code))
        .toString();
  }
}

class PromoCodeBuilder implements Builder<PromoCode, PromoCodeBuilder> {
  _$PromoCode _$v;

  String _validTill;
  String get validTill => _$this._validTill;
  set validTill(String validTill) => _$this._validTill = validTill;

  ListBuilder<String> _vendors;
  ListBuilder<String> get vendors =>
      _$this._vendors ??= new ListBuilder<String>();
  set vendors(ListBuilder<String> vendors) => _$this._vendors = vendors;

  double _rate;
  double get rate => _$this._rate;
  set rate(double rate) => _$this._rate = rate;

  String _createdAt;
  String get createdAt => _$this._createdAt;
  set createdAt(String createdAt) => _$this._createdAt = createdAt;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  PromoCodeBuilder();

  PromoCodeBuilder get _$this {
    if (_$v != null) {
      _validTill = _$v.validTill;
      _vendors = _$v.vendors?.toBuilder();
      _rate = _$v.rate;
      _createdAt = _$v.createdAt;
      _code = _$v.code;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PromoCode other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$PromoCode;
  }

  @override
  void update(void Function(PromoCodeBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$PromoCode build() {
    _$PromoCode _$result;
    try {
      _$result = _$v ??
          new _$PromoCode._(
              validTill: validTill,
              vendors: _vendors?.build(),
              rate: rate,
              createdAt: createdAt,
              code: code);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'vendors';
        _vendors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'PromoCode', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
