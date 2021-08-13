# lib

### ディレクトリ構成

MVVMパターンを採用。(Model, View, ViewModel)

Page(View) <-> PageModel(ViewModel) <-> 

```
lib
├── pages  // 画面
      ├── sample_page
            ├── sample_page.dart  // UIを実装
            └── sample_page_model.dart  // View Model（UIに関わるロジック）
├── utils  // ロジック等
├── widgets  // コンポーネント群
├── models  // モデル
      ├── entities  // Model
      └── controllers  // API, DB (UIに関わらないロジック）
├── main.dart
└── app.dart
```