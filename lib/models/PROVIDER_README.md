# Provider

Providerの最低限の使い方を書いておきます。
（Provider × ChangeNotifier）

## 状態クラス
ChangeNotifierをwithでmixinして、定義する。

```dart
import 'package:flutter/material.dart';

class SampleModel with ChangeNotifier {
  // 変数の定義（プライベート変数）
  int _count = 0;

  // ゲッターを定義
  int get count => _count;

  // メソッドの定義
  void increment(int count) {
    _count = count;
    
    notifyListeners();
  }
}
```
重要なのは、`notifyListeners()`。これを呼び出すと、変更を監視しているWidgetらに変更が通知される（逆に値を変更したのにこれを呼び出さないと、UIに反映されなかったりする。setStateみたいなもの。）
書き方に縛りがあるわけではないけど、
- 外側から変に変更されないように、プライベートに変数を定義（Dartでは、アンダースコア(_)を変数の頭に付けるとプライベート変数になる）。
- 変数を外から参照できるように、ゲッターを定義。
- メソッドを定義（値を変更するときは、`notifyListeners()`を必ず呼び出す。）
という形にしておけばとりあえず大丈夫だと思う多分。

## `app.dart`

`app.dart`で、各Widgetで状態クラスにアクセスできるように設定しています。
複数の状態クラスを扱う（予定）なので、MultiProviderで全体を覆っています。使いたい状態クラスは、providers内で指定します。
新しく状態クラスを定義した際は、app.dartで状態クラスを追加する必要がある。

```dart
Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SampleModel>(create: (_) => SampleModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: customSwatch,
        ),
        home: HomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
```

## 状態クラスにアクセスする。

状態クラスにアクセスする時は、 context.watch・context.select・context.readなどを用いて行う。
context.watch と context.select は変更を監視し、context.read は変更を監視しない（一度参照したらそのあと変更しても変わらない）。
context.select は監視対象を変数一つに絞ることができる。
状態クラス内の関数を呼び出したいときなど、監視を必要としない所で context.read を使うといいと思う。
```dart
class HomePage extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   final count = context.watch<SampleModel>().count;
   return Scaffold(
     body: Center(child: Text("$count")),
     floatingActionButton: FloatingActionButton(
       onPressed: () {
         context.read<SampleModel>().increment();
       }
     ),
   );
 }
}
```
