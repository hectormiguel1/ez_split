import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class NotifierMap<T1, T2> with ChangeNotifier {
  late Map<T1, T2> _observableMap;

  NotifierMap({Map<T1, T2>? initialValues}) {
    _observableMap = initialValues ?? {};
  }

  UnmodifiableMapView<T1, T2> get map => UnmodifiableMapView(_observableMap);

  void addElement(T1 key, T2 element) {
    _observableMap[key] = element;
    notifyListeners();
  }

  void updateElement(T1 key, T2 value) {
    _observableMap[key] = value;
    notifyListeners();
  }

  void remove(T1 key) {
    _observableMap.remove(key);
    notifyListeners();
  }

  void clear() {
    _observableMap.clear();
    notifyListeners();
  }

  Map<String, dynamic> jsonify() => {"elements": jsonEncode(_observableMap)};
}
