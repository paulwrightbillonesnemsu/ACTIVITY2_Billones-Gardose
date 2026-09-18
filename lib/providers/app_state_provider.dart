import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../models/activity.dart';

enum NetworkStatus { checking, wifi, cellular, offline }

enum RequestStatus { waitingForNetwork, sending, sent }

class NetworkRequest {
  final String title;
  RequestStatus status;

  NetworkRequest({required this.title, required this.status});
}

/// Single source of truth for values that must be shared across every
/// screen (theme, profile). Any widget that calls `context.watch` on this
/// provider rebuilds automatically whenever `notifyListeners()` runs.
class AppStateProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  NetworkStatus _networkStatus = NetworkStatus.checking;
  bool _simulatedLoss = false;
  final List<NetworkRequest> _requests = [];
  final List<Timer> _requestTimers = [];
  int _sentRequestCount = 0;
  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ThemeMode _themeMode = ThemeMode.light;
  String _userName = 'Gardo';
  final String _userRole = 'Student / Designer';

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get userName => _userName;
  String get userRole => _userRole;
  NetworkStatus get networkStatus => _simulatedLoss ? NetworkStatus.offline : _networkStatus;
  bool get isNetworkAvailable => networkStatus != NetworkStatus.offline &&
      networkStatus != NetworkStatus.checking;
  bool get isSimulatedLoss => _simulatedLoss;
  List<String> get pendingRequests => List.unmodifiable(
        _requests
            .where((request) => request.status == RequestStatus.waitingForNetwork)
            .map((request) => request.title),
      );
  List<NetworkRequest> get requests => List.unmodifiable(_requests);
  int get sentRequestCount => _sentRequestCount;

  String get networkLabel {
    switch (networkStatus) {
      case NetworkStatus.wifi:
        return 'Wi-Fi';
      case NetworkStatus.cellular:
        return 'Cellular Data';
      case NetworkStatus.offline:
        return 'No connection';
      case NetworkStatus.checking:
        return 'Checking...';
    }
  }

  AppStateProvider() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateNetworkStatus);
    _loadInitialNetworkStatus();
  }

  Future<void> _loadInitialNetworkStatus() async {
    try {
      _updateNetworkStatus(await _connectivity.checkConnectivity());
    } on Object {
      _updateNetworkStatus(const [ConnectivityResult.none]);
    }
  }

  void _updateNetworkStatus(List<ConnectivityResult> results) {
    final nextStatus = results.contains(ConnectivityResult.wifi)
        ? NetworkStatus.wifi
        : results.contains(ConnectivityResult.mobile)
            ? NetworkStatus.cellular
            : results.any((result) => result != ConnectivityResult.none)
                ? NetworkStatus.wifi
                : NetworkStatus.offline;

    if (_networkStatus == nextStatus) return;
    _networkStatus = nextStatus;
    final flushed = _flushPendingRequests();
    if (flushed) {
      notifyListeners();
      return;
    }
    notifyListeners();
  }

  void toggleSimulatedLoss() {
    _simulatedLoss = !_simulatedLoss;
    if (!_simulatedLoss) {
      _flushPendingRequests();
    }
    notifyListeners();
  }

  void startRequest(String requestName) {
    final request = NetworkRequest(
      title: requestName,
      status: isNetworkAvailable
          ? RequestStatus.sending
          : RequestStatus.waitingForNetwork,
    );
    _requests.add(request);
    if (request.status == RequestStatus.sending) _completeRequestLater(request);
    notifyListeners();
  }

  @visibleForTesting
  void setNetworkStatusForTesting(NetworkStatus status) {
    _networkStatus = status;
    _flushPendingRequests();
    notifyListeners();
  }

  bool _flushPendingRequests() {
    final waiting = _requests
        .where((request) => request.status == RequestStatus.waitingForNetwork)
        .toList();
    if (!isNetworkAvailable || waiting.isEmpty) return false;
    for (final request in waiting) {
      request.status = RequestStatus.sending;
      _completeRequestLater(request);
    }
    return true;
  }

  void _completeRequestLater(NetworkRequest request) {
    final timer = Timer(const Duration(milliseconds: 900), () {
      if (_requests.contains(request) && request.status == RequestStatus.sending) {
        request.status = RequestStatus.sent;
        _sentRequestCount++;
        notifyListeners();
      }
    });
    _requestTimers.add(timer);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    for (final timer in _requestTimers) {
      timer.cancel();
    }
    super.dispose();
  }

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
