# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

Gamjoy는 Flutter로 개발된 오목 게임 애플리케이션입니다. Melos를 사용한 모노레포 구조로 관리되며, Clean Architecture 원칙을 따라 구성되어 있습니다.

## 프로젝트 구조

```
gamjoy/
├── melos.yaml                  # Melos 모노레포 설정
├── pubspec.yaml               # 루트 프로젝트 설정
├── analysis_options.yaml     # 글로벌 린트 규칙
├── packages/                  # 공통 라이브러리 패키지들
│   └── core/                  # 공통 핵심 기능 패키지
│       ├── lib/
│       │   ├── presentation/  # 공통 UI 컴포넌트, 테마, 유틸
│       │   ├── domain/        # 공통 엔티티, 리포지토리 인터페이스, 유즈케이스
│       │   └── data/          # 공통 데이터 소스, 모델, 리포지토리 구현체
│       └── pubspec.yaml
└── apps/                      # 애플리케이션들
    └── omok/                  # 오목 게임 애플리케이션
        ├── lib/
        │   ├── presentation/  # UI 레이어 (페이지별로 분리)
        │   │   ├── game/      # 게임 화면
        │   │   │   ├── game_page.dart
        │   │   │   ├── game_view.dart
        │   │   │   └── game_provider.dart
        │   │   ├── user/      # 사용자 화면
        │   │   │   ├── user_page.dart
        │   │   │   ├── user_view.dart
        │   │   │   └── user_provider.dart
        │   │   └── lobby/     # 로비 화면
        │   │       ├── lobby_page.dart
        │   │       ├── lobby_view.dart
        │   │       └── lobby_provider.dart
        │   ├── domain/        # 비즈니스 로직 (도메인별로 분리)
        │   │   ├── game/      # 게임 관련 도메인
        │   │   ├── user/      # 사용자 관련 도메인
        │   │   └── room/      # 방 관련 도메인
        │   └── data/          # 데이터 레이어 (외부 의존성별로 분리)
        │       ├── api/       # REST API 통신
        │       ├── local/     # 로컬 데이터베이스/캐시
        │       └── websocket/ # WebSocket 통신
        └── pubspec.yaml
```

## 아키텍처 가이드

### Clean Architecture 구조
- **Presentation Layer**: UI 컴포넌트와 상태 관리
  - `*_page.dart`: 페이지 엔트리 포인트
  - `*_view.dart`: 실제 UI 렌더링 (ConsumerWidget 사용)
  - `*_provider.dart`: Riverpod Provider로 상태 관리

- **Domain Layer**: 비즈니스 로직과 엔티티
  - `entities/`: 도메인 엔티티
  - `repositories/`: 리포지토리 인터페이스
  - `usecases/`: 비즈니스 유즈케이스

- **Data Layer**: 외부 데이터 소스
  - `datasources/`: 데이터 소스 인터페이스 및 구현
  - `models/`: 데이터 전송 객체(DTO)
  - `repositories/`: 리포지토리 구현체

## 개발 명령어

### Melos 명령어
```bash
# 의존성 설치 (중앙화된 버전 관리 적용)
melos bootstrap

# 모든 패키지 분석
melos analyze

# 모든 패키지 포맷팅
melos format

# 모든 패키지 테스트
melos test

# 모든 패키지 빌드
melos build

# 모든 패키지 정리
melos clean

# 의존성 업데이트
melos get
```

### 개별 패키지 작업
```bash
# 애플리케이션 실행
cd apps/omok
flutter run
flutter test
flutter build apk

# 패키지 테스트
cd packages/core
flutter test
```

### 코드 생성
```bash
# 특정 패키지에서 코드 생성 실행 (Riverpod + Freezed + JSON)
cd packages/core
flutter packages pub run build_runner build --delete-conflicting-outputs

cd apps/omok  
flutter packages pub run build_runner build --delete-conflicting-outputs

# 생성되는 파일들:
# - *.g.dart (Riverpod Provider, JSON Serialization)
# - *.freezed.dart (Freezed 데이터 클래스)
```

## 기술 스택

### 상태 관리
- **flutter_riverpod**: 현대적이고 타입 안전한 상태 관리
- **riverpod_annotation**: Riverpod 코드 생성을 위한 어노테이션
- **riverpod_generator**: Riverpod Provider 자동 생성

### 데이터 모델링
- **freezed**: 불변 데이터 클래스 생성
- **freezed_annotation**: Freezed 어노테이션
- **json_annotation**: JSON 직렬화 어노테이션
- **json_serializable**: JSON 직렬화 코드 생성

### 의존성 주입
- **get_it**: 서비스 로케이터
- **injectable**: 코드 생성을 통한 의존성 주입

### 네트워킹
- **dio**: HTTP 클라이언트
- **retrofit**: REST API 클라이언트 생성
- **web_socket_channel**: WebSocket 통신

### 데이터베이스
- **hive**: 로컬 NoSQL 데이터베이스

## 개발 규칙

### 패키지 구조
1. **packages/**: 공통 라이브러리 패키지들 (core 등)
2. **apps/**: 실행 가능한 애플리케이션들 (omok 등)
3. 새로운 페이지 추가 시 `apps/omok/presentation/[페이지명]/` 디렉터리 생성
4. 각 페이지는 page, view, provider 파일로 구성
   - `*_page.dart`: 라우팅 및 페이지 설정
   - `*_view.dart`: UI 컴포넌트 (ConsumerWidget 상속)
   - `*_provider.dart`: Riverpod Provider로 상태 관리
5. 도메인별로 기능을 분리하여 개발
6. 외부 의존성별로 데이터 소스 분리

### 린트 규칙
- 프로젝트 루트의 `analysis_options.yaml`에 글로벌 린트 규칙 정의
- 모든 패키지에서 동일한 코딩 스타일 적용
- `flutter_lints` 패키지 기반으로 추가 규칙 적용

### 테스트
- 각 패키지별로 `test/` 디렉터리에 테스트 코드 작성
- Riverpod Provider 테스트 (`ProviderContainer` 사용)
- `mocktail`을 사용한 모킹

## 주의사항

### 코드 생성 파일
- `*.g.dart`: Riverpod Provider와 JSON 직렬화 코드 (자동 생성)
- `*.freezed.dart`: Freezed 불변 데이터 클래스 코드 (자동 생성)
- `*.gr.dart`: 기타 코드 생성 파일 (자동 생성)
- **주의**: 생성된 파일들을 직접 수정하지 말 것
- `.gitignore`에 이미 포함되어 있음

### 패키지 의존성
- `packages/core` 패키지는 공통 라이브러리 기능을 제공
- `apps/omok` 앱은 `packages/core` 패키지를 의존성으로 가짐
- 앱간 직접적인 의존성은 피하고, 공통 기능은 `packages/` 에 배치

### 중앙화된 버전 관리
- **melos.yaml**에서 모든 공통 라이브러리 버전을 중앙 관리
- 각 패키지의 `pubspec.yaml`에서는 버전 번호 생략
- `melos bootstrap` 명령으로 중앙에서 정의된 버전 자동 적용
- 버전 업데이트 시 `melos.yaml`만 수정하면 모든 패키지에 반영

### 개발 워크플로우
1. 새로운 기능 개발 시 해당 패키지의 Clean Architecture 구조 따르기
2. 공통 기능은 `core` 패키지에 추가
3. 라이브러리 버전 업데이트 시 `melos.yaml`에서만 수정
4. `melos bootstrap`으로 의존성 동기화
5. 코드 변경 후 `melos analyze`로 린트 검사
6. 테스트 작성 후 `melos test`로 전체 테스트 실행