# Scrumdinger

Apple の SwiftUI チュートリアル「[Develop in Swift / App Dev Training](https://developer.apple.com/tutorials/app-dev-training)」の題材アプリ **Scrumdinger** を、学習のために1章ずつ実装しているリポジトリです。

Scrumdinger は、デイリースクラム（毎日の短いミーティング）を進行するためのアプリです。

- ミーティング（スクラム）を登録し、参加者・時間・テーマ色を設定する
- ミーティングを始めると、参加者ごとの持ち時間をタイマーで計り、時間が来たら効果音を鳴らして次の人に交代する
- 開いたミーティングを履歴として記録する
- データは端末に保存され、アプリを起動し直しても残る

## 動かし方

| 項目 | バージョン |
|---|---|
| Xcode | 26.3 で確認 |
| deployment target | iOS 18.0 |

1. `Scrumdinger.xcodeproj` を Xcode で開く
2. iPhone のシミュレータを選んで実行する

初めて起動したときは、一覧が空です。右上の「+」からスクラムを追加してください。サンプルデータ（`DailyScrum.sampleData`）は、Xcode のプレビューでだけ使っています。

コマンドラインでビルド・テストする場合：

```sh
xcodebuild test -project Scrumdinger.xcodeproj -scheme Scrumdinger \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## 進み具合

| 章 | 状態 | PR |
|---|---|---|
| Getting started 〜 Creating the edit view | 完了 | （PR を使う前に main へ直接コミット） |
| Passing data with bindings | 完了 | [#1](https://github.com/endlmk/Scrumdinger/pull/1) |
| Managing state and life cycle | 完了 | [#2](https://github.com/endlmk/Scrumdinger/pull/2) |
| Updating app data | 完了 | [#3](https://github.com/endlmk/Scrumdinger/pull/3) |
| Persisting data | 完了 | [#4](https://github.com/endlmk/Scrumdinger/pull/4) |
| Handling errors | 完了 | [#5](https://github.com/endlmk/Scrumdinger/pull/5) |
| Drawing the timer view | 未着手 | |
| Transcribing speech to text | 未着手 | |

各 PR には、その章で学んだことを「学びのメモ」としてコメントで残しています。

### 進め方
- 1章につき1つのブランチと PR を作り、merge commit で main に取り込む
- チュートリアルの Section ごとに1コミット（`<章の名前>, Section N.`）
- 章の終わりに理解度チェックを行い、その補足を PR にコメントしてから merge する

## ファイル構成

```
Scrumdinger/
├── ScrumdingerApp.swift        アプリの入口。SwiftData のコンテナを作る
├── ScrumsView.swift            スクラムの一覧（@Query で取得）
├── CardView.swift              一覧の1行
├── DetailView.swift            スクラムの詳細・履歴
├── DetailEditView.swift        スクラムの編集・新規作成（共通の画面）
├── NewScrumSheet.swift         新規作成のシート
├── ThemePicker.swift           テーマ色の選択
├── ThemeView.swift             テーマ色の見本
├── MeetingView.swift           ミーティング画面
├── MeetingHeaderView.swift     経過時間・残り時間・プログレスバー
├── MeetingFooterView.swift     現在の話者と「次の話者」ボタン
├── ScrumProgressViewStyle.swift  テーマ色のプログレスバー
├── ErrorView.swift             エラー画面
├── TrailingIconLabelStyle.swift  アイコンを右側に置くラベルの見た目
├── ding.wav                    話者交代の効果音
├── Models/
│   ├── DailyScrum.swift        スクラム（@Model）
│   ├── Attendee.swift          参加者（@Model）
│   ├── History.swift           ミーティングの履歴（@Model）
│   ├── Theme.swift             テーマ色（Codable な enum）
│   ├── ScrumTimer.swift        ミーティングのタイマー（ObservableObject）
│   ├── AVPlayer+Ding.swift     効果音のプレーヤー
│   └── ErrorWrapper.swift      エラーを画面に渡すための入れ物
└── Preview Content/
    └── PreviewContainer.swift  プレビュー用のサンプルデータ（PreviewModifier）
```

## 現行版チュートリアルとの違い

このリポジトリは、2022 年ごろの旧版チュートリアルで始めて、途中から現行版のページを見ながら進めています。そのため、現行版とは次の点が違います。

| 項目 | このリポジトリ | 現行版チュートリアル |
|---|---|---|
| ナビゲーション | `NavigationView` | `NavigationStack` |
| タイマーの監視 | `ObservableObject` + `@Published` + `@StateObject` | `@Observable` + `@State` |
| プレビュー | 主に `PreviewProvider`（SwiftData を使うものだけ `#Preview(traits:)`） | `#Preview` |
| `TimerKit` / `ThemeKit` パッケージ | 使わず、必要なファイルをアプリのターゲットに直接追加 | Swift パッケージとして追加 |
| 新規スクラムの既定のテーマ | `.seafoam` | `.sky` |

永続化（Persisting data）は、現行版と同じく **SwiftData** を使っています。そのために deployment target を iOS 18.0 に上げました。

## 既知の課題

- **保存に失敗しても、変更がメモリ上に残る**：`DetailEditView.saveEdits()` は、オブジェクトを書き換えて `context.insert` してから `context.save()` する。そのため `save()` が失敗しても、アプリを起動し直すまでは、一覧や詳細画面で変更が反映されたように見える。`catch` で `context.rollback()` を呼ぶ案は未検証（[#5](https://github.com/endlmk/Scrumdinger/pull/5)）
- **保存に失敗したスクラムが一覧に2件表示される**：上の状態のとき、同じスクラムが2件表示された。原因は未調査（[#5](https://github.com/endlmk/Scrumdinger/pull/5)）
- **履歴の参加者が、スクラムの参加者と共有されている**：`History(attendees: scrum.attendees)` は `@Model` の `Attendee` を共有するので、履歴がその時点のスナップショットになっていない。参加者の名前を変える機能を足すと、過去の履歴の名前も変わる（[#4](https://github.com/endlmk/Scrumdinger/pull/4)）

## ライセンス

このリポジトリのコードは、Apple のサンプルコード（Scrumdinger）をもとにしています。特に次のファイルは、チュートリアルの配布ファイル（`TimerKit`）から取り込んだものを改変しています。

- `Scrumdinger/Models/ScrumTimer.swift`
- `Scrumdinger/Models/AVPlayer+Ding.swift`
- `Scrumdinger/ScrumProgressViewStyle.swift`
- `Scrumdinger/ding.wav`

Apple のサンプルコードのライセンスは [ThirdPartyLicenses/Apple-Scrumdinger-Sample-LICENSE.txt](ThirdPartyLicenses/Apple-Scrumdinger-Sample-LICENSE.txt) にあります。
