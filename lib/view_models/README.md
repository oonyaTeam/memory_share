# View Model

UIに直接関わるロジックを記述。

ChangeNotifierクラスを継承していて、View側でViewModel(ChangeNotifier)をProviderを使って呼び出す。
Repositoryクラスを持ち、ViewModelからはRepositoryクラス内のロジックを呼び出す。