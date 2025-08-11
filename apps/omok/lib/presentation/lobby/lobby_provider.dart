import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lobby_provider.g.dart';
part 'lobby_provider.freezed.dart';

/// 로비 상태를 나타내는 클래스
@freezed
class LobbyState with _$LobbyState {
  const factory LobbyState({
    @Default(false) bool isLoading,
    @Default(0) int playerCount,
    @Default([]) List<String> roomList,
  }) = _LobbyState;
}

/// 로비 상태를 관리하는 Provider
@riverpod
class LobbyNotifier extends _$LobbyNotifier {
  @override
  LobbyState build() {
    return const LobbyState();
  }

  /// 게임 방 생성
  Future<void> createRoom() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // TODO: 실제 방 생성 로직 구현
      await Future.delayed(const Duration(seconds: 1));
      
      final newRoomList = List<String>.from(state.roomList)..add('새로운 방');
      state = state.copyWith(
        isLoading: false,
        roomList: newRoomList,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// 게임 방 참가
  Future<void> joinRoom(String roomId) async {
    state = state.copyWith(isLoading: true);
    
    try {
      // TODO: 실제 방 참가 로직 구현
      await Future.delayed(const Duration(seconds: 1));
      
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// 플레이어 수 업데이트
  void updatePlayerCount(int count) {
    state = state.copyWith(playerCount: count);
  }
}

/// 현재 접속 플레이어 수를 제공하는 Provider
@riverpod
int onlinePlayerCount(OnlinePlayerCountRef ref) {
  // TODO: 실제 서버에서 플레이어 수 가져오기
  return 42;
}