import 'package:softvision_project/disposable_provider.dart';

class HomeViewModel extends DisposableProvider {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  @override
  void disposeValues() {
    _loading = false;
  }
}
