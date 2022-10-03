import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/date_and_time.dart';
import 'text_field_widget.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({Key? key, required this.timeController})
      : super(key: key);
  final TextEditingController timeController;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, right: 15, left: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Час',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  readOnly: true,
                  controller: widget.timeController,
                  maxLineCount: 1,
                  hintText: widget.timeController.text,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      Navigator.of(context).push(
                        showPicker(
                          accentColor: AppColors.getMaterialColorFromColor(
                              themeProvider.selectedForegroundColor),
                          okText: 'Готово',
                          okStyle: const TextStyle(fontWeight: FontWeight.bold),
                          cancelText: 'Відмінити',
                          cancelStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          hourLabel: 'година',
                          minuteLabel: 'хвилина',
                          is24HrFormat: true,
                          iosStylePicker: true,
                          context: context,
                          value: TimeOfDay.now(),
                          onChange: (p0) {},
                          minuteInterval: MinuteInterval.ONE,
                          // Optional onChange to receive value as DateTime
                          onChangeDateTime: (DateTime dateTime) {
                            widget.timeController.text =
                                DateAndTime.getFromatTime(
                                    TimeOfDay.fromDateTime(dateTime));
                          },
                        ),
                      );
                    },
                    splashRadius: 17,
                    icon: Icon(
                      Icons.access_time,
                      color: AppColors.getMaterialColorFromColor(
                          themeProvider.selectedForegroundColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
