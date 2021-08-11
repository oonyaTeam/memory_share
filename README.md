# memory_share

memory_share mobile app.

### Commit Message

**日本語で**

```
"Subject: description"
```

- Add
- Update
- Fix
- Remove

## SetUp to Run

### 環境変数の設定
プロジェクトのルートに `.env` ファイルを作成。以下のように記述する

```
GOOGLE_MAPS_API_KEY=YOUR_GOOGLE_MAPS_API_KEY
API_ENDPOINT=YOUR_API_ENDPOINT
```

※API_ENDPOINTには、`https://xxxxxx.xxx.com/` ←最後の`/`を忘れずに。

### [firebase] google-services.json

google-services.jsonを、`android/app/`内に配置する。