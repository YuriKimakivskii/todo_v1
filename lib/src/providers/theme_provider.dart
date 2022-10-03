import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/theme_model.dart';

class ThemeProvider with ChangeNotifier {
  Color selectedPrimaryColor = Colors.grey;
  Color selectedForegroundColor = Colors.black;

  ThemeProvider() {
    _setup();
  }

  setSelectedPrimaryColor(Color color) async {
    selectedPrimaryColor = color;
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ThemeModelAdapter());
    }

    final box = await Hive.openBox<ThemeModel>('theme_box');
    final colorModel = box.get(0) ?? ThemeModel();
    colorModel.selectedPrimaryColor = color.value;
    await box.put(0, colorModel);
    notifyListeners();
  }

  setSelectedForegroundColor(Color color) async {
    selectedForegroundColor = color;
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ThemeModelAdapter());
    }

    final box = await Hive.openBox<ThemeModel>('theme_box');
    final colorModel = box.get(0) ?? ThemeModel();
    colorModel.selectedForegroundColor = color.value;
    await box.put(0, colorModel);
    notifyListeners();
  }

  _readColorsFromHive(Box<ThemeModel> box) {
    selectedPrimaryColor =
        Color(box.get(0)?.selectedPrimaryColor ?? Colors.grey.value);
    selectedForegroundColor =
        Color(box.get(0)?.selectedForegroundColor ?? Colors.black.value);
    notifyListeners();
  }

  void _setup() async {
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(ThemeModelAdapter());
    }

    final box = await Hive.openBox<ThemeModel>('theme_box');
    _readColorsFromHive(box);
    box.listenable().addListener(() => _readColorsFromHive(box));
    notifyListeners();
  }
}
