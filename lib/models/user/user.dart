import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

part 'user.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  factory UserState({
    @Default("") String uid,
  }) = _UserState;

  UserState._();
}

final userProvider = StateNotifierProvider<UserStateNotifier, UserState>(
  (ref) => UserStateNotifier(ref.read),
);

class UserStateNotifier extends StateNotifier<UserState> {
  UserStateNotifier() : super(const UserState());
}