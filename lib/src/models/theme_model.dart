import 'package:hive_flutter/hive_flutter.dart';

part 'theme_model.g.dart';

@HiveType(typeId: 2)
class ThemeModel {
  @HiveField(1)
  int? selectedPrimaryColor;

  @HiveField(2)
  int? selectedForegroundColor;

  ThemeModel();
}
