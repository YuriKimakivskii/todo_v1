import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({super.key});

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
// Color for the picker shown in Card on the screen.
  late Color screenPickerColor;

  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;

  // Color for picker using the color select dialog.
  late Color dialogSelectColor;

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue; // Material blue.
    dialogPickerColor = Colors.red; // Material red.
    dialogSelectColor = const Color(0xFFA239CA); // A purple color.
  }

  void onPrimaryColorChanged(ThemeProvider themeProvider, Color color) {
    setState(() {
      themeProvider.setSelectedPrimaryColor(color);
      dialogPickerColor = color;
    });
  }

  void onForegroundColorChanged(ThemeProvider themeProvider, Color color) {
    setState(() {
      themeProvider.setSelectedForegroundColor(color);
      dialogPickerColor = color;
    });
  }

  Future<bool> colorPickerDialog(Function(Color) onColorChanged) async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: onColorChanged,
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Виберіть колір',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Виберіть відтінок',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Виберіть колір та відтінок',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: ColorTools.primaryColorNames,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Налаштування'),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          children: <Widget>[
            ListTile(
              title: const Text('Фоновий колір'),
              subtitle: const Text(
                'Натисніть на плитку з кольором, щоб змінити',
              ),
              trailing: ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: themeProvider.selectedPrimaryColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = dialogPickerColor;

                  if (!(await colorPickerDialog((color) =>
                      onPrimaryColorChanged(themeProvider, color)))) {
                    setState(() {
                      dialogPickerColor = colorBeforeDialog;
                    });
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Основний колір'),
              subtitle:
                  const Text('Натисніть на плитку з кольором, щоб змінити'),
              trailing: ColorIndicator(
                width: 44,
                height: 44,
                borderRadius: 4,
                color: themeProvider.selectedForegroundColor,
                onSelectFocus: false,
                onSelect: () async {
                  final Color colorBeforeDialog = dialogPickerColor;

                  if (!(await colorPickerDialog((color) =>
                      onForegroundColorChanged(themeProvider, color)))) {
                    setState(() {
                      dialogPickerColor = colorBeforeDialog;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
