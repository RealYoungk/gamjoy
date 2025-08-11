import 'package:freezed_annotation/freezed_annotation.dart';

part 'lobby_state.freezed.dart';

/// 로비 상태를 나타내는 클래스
@freezed
class LobbyState with _$LobbyState {
  const factory LobbyState({
    @Default(false) bool isLoading,
    @Default(0) int playerCount,
    @Default(<String>[]) List<String> roomList,
  }) = _LobbyState;
}
