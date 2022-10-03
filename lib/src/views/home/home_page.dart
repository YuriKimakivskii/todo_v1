import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../../providers/todo_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/date_and_time.dart';
import '../settings/settings_page.dart';
import '../todo_form/todo_form_page.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/todo_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, todoProvider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: InkWell(
              onTap: () => showGeneralDialog(
                context: context,
                pageBuilder: (BuildContext buildContext,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return const SettingsPageWidget();
                },
                barrierDismissible: true,
                barrierLabel:
                    MaterialLocalizations.of(context).modalBarrierDismissLabel,
                barrierColor: Colors.black,
                transitionDuration: const Duration(milliseconds: 200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      DateAndTime.today,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text('Сьогодні',
                      style: TextStyle(
                        fontSize: 20,
                      )),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            actions: const [
              _AddNewTaskButton(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: const [
                CalendarWidget(),
                TodoListWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddNewTaskButton extends StatelessWidget {
  const _AddNewTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async => showGeneralDialog(
              context: context,
              pageBuilder: (BuildContext buildContext,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return const TodoFormPage();
              },
              barrierDismissible: true,
              barrierLabel:
                  MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black,
              transitionDuration: const Duration(milliseconds: 200),
            ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                  AppColors.getMaterialColorFromColor(
                      themeProvider.selectedPrimaryColor)),
              backgroundColor: MaterialStateProperty.all(
                  AppColors.getMaterialColorFromColor(
                      themeProvider.selectedForegroundColor)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            child: const Text(
              '+ Додати запис',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        );
      },
    );
  }
}
