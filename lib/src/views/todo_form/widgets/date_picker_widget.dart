import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../providers/theme_provider.dart';
import '../../../utils/app_colors.dart';
import 'text_field_widget.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key, required this.dateController})
      : super(key: key);
  final TextEditingController dateController;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late String date;

  @override
  Widget build(BuildContext context) {
    date = widget.dateController.text;
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 15, right: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Дата',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                TextFieldWidget(
                  readOnly: true,
                  controller: widget.dateController,
                  maxLineCount: 1,
                  hintText: date,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AppColors.getMaterialColorFromColor(
                                    themeProvider.selectedForegroundColor),
                                onPrimary: AppColors.getMaterialColorFromColor(
                                    themeProvider.selectedPrimaryColor),
                                onSurface: Colors.black,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      AppColors.getMaterialColorFromColor(
                                          themeProvider
                                              .selectedForegroundColor),
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() {
                          widget.dateController.text =
                              DateFormat('yyyy-MM-dd', 'uk').format(DateTime(
                                  picked.year, picked.month, picked.day));
                        });
                      }
                    },
                    splashRadius: 17,
                    icon: Icon(
                      Icons.calendar_today,
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
