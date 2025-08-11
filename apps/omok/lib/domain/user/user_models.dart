import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_models.freezed.dart';
part 'user_models.g.dart';

/// 사용자 상태
enum UserStatus {
  offline,
  online,
  inGame,
  away;
}

/// 사용자 정보
@freezed
class User with _$User {
  const factory User({
    required String id,
    required String nickname,
    required String email,
    @Default(UserStatus.offline) UserStatus status,
    @Default(0) int rating,
    @Default(0) int wins,
    @Default(0) int losses,
    DateTime? lastSeen,
    String? avatarUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// 게임 통계
@freezed
class GameStats with _$GameStats {
  const factory GameStats({
    required int totalGames,
    required int wins,
    required int losses,
    required int draws,
    required double winRate,
    required int currentStreak,
    required int maxStreak,
  }) = _GameStats;

  factory GameStats.fromJson(Map<String, dynamic> json) =>
      _$GameStatsFromJson(json);
}

/// 사용자 프로필
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required User user,
    required GameStats stats,
    @Default(<String>[]) List<String> achievements,
    DateTime? createdAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
