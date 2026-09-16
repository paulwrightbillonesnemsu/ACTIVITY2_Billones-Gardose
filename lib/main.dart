import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_state_provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    // Wrapping the whole app means every descendant screen can read and
    // react to the same AppStateProvider instance.
    ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // watch() rebuilds MaterialApp (and therefore re-themes everything
    // below it) the instant the theme toggle in Settings is pressed.
    final appState = context.watch<AppStateProvider>();

    return MaterialApp(
      title: 'Flutter Lab Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: appState.themeMode,
      home: const MainScreen(),
    );
  }
}
