import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  late Brightness _brightness;
  late MaterialColor _colorTheme;
  late bool _useMaterial3;
  late bool _shouldUseDrower;

  AppTheme(
      {Brightness initialBrightness = Brightness.dark,
      MaterialColor initialTheme = Colors.blue,
      bool useMaterial3 = true,
      bool shouldUseDrower = false}) {
    _brightness = initialBrightness;
    _colorTheme = initialTheme;
    _useMaterial3 = useMaterial3;
    _shouldUseDrower = shouldUseDrower;
  }

  Brightness get brightness => _brightness;
  MaterialColor get colorTheme => _colorTheme;
  bool get useMaterial3 => _useMaterial3;

  set colorTheme(MaterialColor theme) {
    _colorTheme = theme;
    notifyListeners();
  }

  void toggleBrightness() {
    _brightness =
        _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    notifyListeners();
  }

  void toggleMaterial3() {
    _useMaterial3 = !_useMaterial3;
    notifyListeners();
  }

  bool get shouldUseDrower => _shouldUseDrower;

  set shouldUseDrower(bool val) {
    _shouldUseDrower = val;
    notifyListeners();
  }

  void updateUI(BuildContext context) {
        final width = MediaQuery.of(context).size.width;
    if (width <= 500) {
      shouldUseDrower = true;
    }
    else {
      shouldUseDrower = false;
    }
    notifyListeners();
  }


}
