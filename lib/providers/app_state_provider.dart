import 'package:flutter/material.dart';
import '../models/activity.dart';

/// Single source of truth for values that must be shared across every
/// screen (theme, profile). Any widget that calls `context.watch` on this
/// provider rebuilds automatically whenever `notifyListeners()` runs.
class AppStateProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _userName = 'Gardo';
  final String _userRole = 'Student / Designer';

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get userName => _userName;
  String get userRole => _userRole;

  void setThemeMode(ThemeMode mode) {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme() {
    setThemeMode(isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  void updateUserName(String name) {
    if (name.trim().isEmpty) return;
    _userName = name.trim();
    notifyListeners();
  }

  // Static demo data standing in for a future API / database call.
  final List<Activity> activities = const [
    Activity(
      id: 'activity_1',
      label: 'Activity 1',
      title: 'Flutter Lab Portfolio App',
      dateDisplay: 'September 08, 2026',
      deadline: 'September 16, 2026',
      time: '11:59 PM',
      objective:
          'Build a multi-screen Flutter application that will serve as the '
          'master compilation app for all your future laboratory activities.',
      instructions: [
        InstructionItem(
          title: 'Project Setup',
          description: 'Create a new Flutter project.',
        ),
        InstructionItem(
          title: 'Multi-Screen Navigation',
          description:
              'Design a responsive Home Dashboard that acts as a menu. '
              'Implement navigation routes to at least two separate '
              '"Activity" screens.',
        ),
        InstructionItem(
          title: 'Widget Architecture',
          description:
              'Demonstrate clear declarative UI principles. Use '
              'StatelessWidget for static components (like custom buttons '
              'or cards) and StatefulWidget for local, screen-specific '
              'interactions.',
        ),
        InstructionItem(
          title: 'Responsive Layout',
          description:
              'Use native layout widgets (Column, Row, Expanded, or '
              'Flexible) to ensure your screens adapt properly to '
              'different device sizes without overflowing.',
        ),
      ],
    ),
    Activity(
      id: 'activity_2',
      label: 'Activity 2',
      title: 'Active Network & Handover Handling',
      dateDisplay: 'September 11, 2026',
      deadline: 'September 18, 2026',
      time: '11:59 PM',
      objective:
          'Implement handling for active network changes and connection '
          'handovers within the application so the UI reacts gracefully to '
          'connectivity changes.',
      instructions: [
        InstructionItem(
          title: 'Network Detection',
          description:
              'Detect changes in network connectivity in real time.',
        ),
        InstructionItem(
          title: 'Handover Logic',
          description:
              'Gracefully handle transitions between network types without '
              'losing application state.',
        ),
      ],
    ),
  ];
}
