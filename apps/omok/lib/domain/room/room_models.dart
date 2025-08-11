import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:omok/domain/user/user_models.dart';
import 'package:omok/domain/game/game_models.dart';

part 'room_models.freezed.dart';
part 'room_models.g.dart';

/// 방 상태
enum RoomStatus {
  waiting,    // 대기 중
  playing,    // 게임 진행 중
  finished;   // 게임 종료
}

/// 플레이어 역할
enum PlayerRole {
  host,      // 방장
  guest;     // 게스트
}

/// 방에 참가한 플레이어 정보
@freezed
class RoomPlayer with _$RoomPlayer {
  const factory RoomPlayer({
    required User user,
    required PlayerRole role,
    required StoneColor stoneColor,
    required DateTime joinedAt,
    @Default(true) bool isReady,
  }) = _RoomPlayer;

  factory RoomPlayer.fromJson(Map<String, dynamic> json) => 
      _$RoomPlayerFromJson(json);
}

/// 방 설정
@freezed
class RoomSettings with _$RoomSettings {
  const factory RoomSettings({
    @Default(15) int boardSize,
    @Default(false) bool isPrivate,
    @Default(300) int timeLimit, // 초 단위
    @Default(false) bool allowSpectators,
    String? password,
  }) = _RoomSettings;

  factory RoomSettings.fromJson(Map<String, dynamic> json) => 
      _$RoomSettingsFromJson(json);
}

/// 게임 방 정보
@freezed
class GameRoom with _$GameRoom {
  const factory GameRoom({
    required String id,
    required String name,
    required RoomStatus status,
    required RoomSettings settings,
    @Default([]) List<RoomPlayer> players,
    @Default([]) List<User> spectators,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? finishedAt,
    GameState? gameState,
  }) = _GameRoom;

  factory GameRoom.fromJson(Map<String, dynamic> json) => 
      _$GameRoomFromJson(json);
}

/// 방 생성 요청
@freezed
class CreateRoomRequest with _$CreateRoomRequest {
  const factory CreateRoomRequest({
    required String name,
    required RoomSettings settings,
  }) = _CreateRoomRequest;

  factory CreateRoomRequest.fromJson(Map<String, dynamic> json) => 
      _$CreateRoomRequestFromJson(json);
}

/// 방 참가 요청
@freezed
class JoinRoomRequest with _$JoinRoomRequest {
  const factory JoinRoomRequest({
    required String roomId,
    String? password,
  }) = _JoinRoomRequest;

  factory JoinRoomRequest.fromJson(Map<String, dynamic> json) => 
      _$JoinRoomRequestFromJson(json);
}