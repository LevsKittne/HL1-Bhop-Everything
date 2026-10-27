# HL1-Bhop-Everything — GoldSrc 버니합·연속 점프·공중 스트레이프

[English / Languages / 多语言 / Языки](README.md) · **한국어**

AI 코딩 도우미로 수정 가능한 3D 게임에 Half-Life 1 / GoldSrc 방식의 버니합(bhop), 공중 가속과 자동 점프를 적용하는 안내서입니다. Unity, Unreal Engine, Godot 가이드와 C++·C#·GDScript 계산 예제 및 공통 테스트가 포함되어 있습니다.

## 시작하기

저장소를 내려받고 파일을 읽고 수정할 수 있는 AI 도구에서 여세요. 아래 <경로>를 실제 게임 또는 프로젝트 경로로 바꾸세요.

[영어 단계별 안내서](docs/START-HERE.en.md)

```text
AGENTS.md와 docs/START-HERE.en.md를 읽어 주세요.
게임/프로젝트 <경로>에 GoldSrc 방식의 classic-bhop, 점프 키를 누르는 동안의
자동 점프, 읽기 쉬운 수평 UPS 속도계를 추가해 주세요.
먼저 엔진, 단위 환산, 속도를 쓰는 코드, 이동 권한 모델을 확인해 주세요.
기존 컨트롤러에 통합하고 정상 점프 높이, 충돌, 웅크리기 공간 검사와 조작을 유지해 주세요.
해당 엔진 가이드를 한국어로 번역하되 수식과 단위를 유지해 주세요.
구현, 빌드, 테스트 후 설치와 복원 절차 및 실제 결과를 알려 주세요.
실행하지 못한 테스트는 명시하고 의사 코드만으로 완료했다고 하지 마세요.
```

소스 코드, 모드 API 또는 검증된 확장 지점이 필요합니다. 모든 게임에 바로 적용되는 범용 패치는 아닙니다. 멀티플레이에서는 서버 시뮬레이션과 클라이언트 예측의 이동 규칙이 일치해야 합니다.

`goldsrc-stock`: HL1 / GoldSrc · `classic-bhop`: stock limiter disabled.

## 번역 범위

이 소개와 AI 요청문은 한국어입니다. 영어 단계별 안내서가 있으며, 상세 엔진 문서는 현재 주로 러시아어입니다. 수식, 단위와 검증 요구 사항을 유지하며 번역하도록 요청하세요. 실제 검증 범위는 VALIDATION.md에서 확인하세요.

[Unity](docs/UNITY.md) · [Unreal Engine](docs/UNREAL.md) · [Godot](docs/GODOT.md) · [Algorithm](docs/ALGORITHM.md) · [Tests](docs/TESTING.md) · [VALIDATION.md](VALIDATION.md) · [MIT](LICENSE)
