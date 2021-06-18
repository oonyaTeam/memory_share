// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;


final _privateConstructorUsedError = UnsupportedError('It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserStateTearOff {
  const _$UserStateTearOff();

_UserState call({ String* uid = ""}) {
  return  _UserState(uid:uid,);
}

}

/// @nodoc
const $UserState = _$UserStateTearOff();

/// @nodoc
mixin _$UserState {

 String* get uid => throw _privateConstructorUsedError;






@JsonKey(ignore: true)
$UserStateCopyWith<UserState> get copyWith => throw _privateConstructorUsedError;

}

/// @nodoc
abstract class $UserStateCopyWith<$Res>  {
  factory $UserStateCopyWith(UserState value, $Res Function(UserState) then) = _$UserStateCopyWithImpl<$Res>;
$Res call({
 String* uid
});



}

/// @nodoc
class _$UserStateCopyWithImpl<$Res> implements $UserStateCopyWith<$Res> {
  _$UserStateCopyWithImpl(this._value, this._then);

  final UserState _value;
  // ignore: unused_field
  final $Res Function(UserState) _then;

@override $Res call({Object? uid = freezed,}) {
  return _then(_value.copyWith(
uid: uid == freezed ? _value.uid : uid // ignore: cast_nullable_to_non_nullable
as String*,
  ));
}

}


/// @nodoc
abstract class _$UserStateCopyWith<$Res> implements $UserStateCopyWith<$Res> {
  factory _$UserStateCopyWith(_UserState value, $Res Function(_UserState) then) = __$UserStateCopyWithImpl<$Res>;
@override $Res call({
 String* uid
});



}

/// @nodoc
class __$UserStateCopyWithImpl<$Res> extends _$UserStateCopyWithImpl<$Res> implements _$UserStateCopyWith<$Res> {
  __$UserStateCopyWithImpl(_UserState _value, $Res Function(_UserState) _then)
      : super(_value, (v) => _then(v as _UserState));

@override
_UserState get _value => super._value as _UserState;

@override $Res call({Object? uid = freezed,}) {
  return _then(_UserState(
uid: uid == freezed ? _value.uid : uid // ignore: cast_nullable_to_non_nullable
as String*,
  ));
}


}

/// @nodoc


class _$_UserState extends _UserState  with DiagnosticableTreeMixin {
  const _$_UserState({this.uid = ""}): super._();

  

@JsonKey(defaultValue: "") @override  final String* uid;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserState(uid: $uid)';
}

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  super.debugFillProperties(properties);
  properties
    ..add(DiagnosticsProperty('type', 'UserState'))
    ..add(DiagnosticsProperty('uid', uid));
}

@override
bool operator ==(dynamic other) {
  return identical(this, other) || (other is _UserState&&(identical(other.uid, uid) || const DeepCollectionEquality().equals(other.uid, uid)));
}

@override
int get hashCode => runtimeType.hashCode ^ const DeepCollectionEquality().hash(uid);

@JsonKey(ignore: true)
@override
_$UserStateCopyWith<_UserState> get copyWith => __$UserStateCopyWithImpl<_UserState>(this, _$identity);






}


abstract class _UserState extends UserState {
  const factory _UserState({ String* uid}) = _$_UserState;
  const _UserState._(): super._();

  

@override  String* get uid => throw _privateConstructorUsedError;
@override @JsonKey(ignore: true)
_$UserStateCopyWith<_UserState> get copyWith => throw _privateConstructorUsedError;

}
