import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_models.freezed.dart';
part 'game_models.g.dart';

/// 오목판 위치를 나타내는 좌표
@freezed
class Position with _$Position {
  const factory Position({
    required int row,
    required int col,
  }) = _Position;

  factory Position.fromJson(Map<String, dynamic> json) => 
      _$PositionFromJson(json);
}

/// 오목 돌의 색상
enum StoneColor {
  black,
  white;

  /// 상대방 돌 색상 반환
  StoneColor get opposite {
    switch (this) {
      case StoneColor.black:
        return StoneColor.white;
      case StoneColor.white:
        return StoneColor.black;
    }
  }
}

/// 오목판의 한 칸 상태
@freezed
class BoardCell with _$BoardCell {
  const factory BoardCell({
    required Position position,
    StoneColor? stone,
  }) = _BoardCell;

  factory BoardCell.fromJson(Map<String, dynamic> json) => 
      _$BoardCellFromJson(json);
}

/// 게임 상태
enum GameStatus {
  waiting,    // 대기 중
  playing,    // 진행 중  
  finished,   // 종료
  paused;     // 일시정지
}

/// 게임 결과
@freezed
class GameResult with _$GameResult {
  const factory GameResult({
    required StoneColor winner,
    required List<Position> winningLine,
    required DateTime finishedAt,
  }) = _GameResult;

  factory GameResult.fromJson(Map<String, dynamic> json) => 
      _$GameResultFromJson(json);
}

/// 오목 게임 상태
@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default([]) List<List<BoardCell?>> board,
    @Default(StoneColor.black) StoneColor currentPlayer,
    @Default(GameStatus.waiting) GameStatus status,
    @Default([]) List<Position> moveHistory,
    GameResult? result,
    @Default(false) bool isMyTurn,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) => 
      _$GameStateFromJson(json);
}

/// 게임 이동 정보
@freezed
class GameMove with _$GameMove {
  const factory GameMove({
    required Position position,
    required StoneColor stone,
    required DateTime timestamp,
    required String playerId,
  }) = _GameMove;

  factory GameMove.fromJson(Map<String, dynamic> json) => 
      _$GameMoveFromJson(json);
}