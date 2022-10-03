import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'providers/todo_provider.dart';
import 'utils/app_colors.dart';
import 'views/home/home_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => ThemeProvider())),
        ChangeNotifierProvider(create: ((context) => TodoProvider())),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('uk', 'UA'),
            ],
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: AppColors.getMaterialColorFromColor(
                  themeProvider.selectedPrimaryColor),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.getMaterialColorFromColor(
                        themeProvider.selectedForegroundColor),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(
                    AppColors.getMaterialColorFromColor(
                        themeProvider.selectedForegroundColor),
                  ),
                ),
              ),
              appBarTheme: AppBarTheme(
                  foregroundColor: AppColors.getMaterialColorFromColor(
                      themeProvider.selectedForegroundColor)),
            ),
            routes: {
              '/home': (context) => const HomePage(),
            },
            initialRoute: '/home',
          );
        },
      ),
    );
  }
}
