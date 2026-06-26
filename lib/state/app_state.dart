import 'package:flutter/material.dart';

import '../services/storage_service.dart';

class AppState extends ChangeNotifier {
  AppState(this._storage);

  final StorageService _storage;
  bool _isLoaded = false;
  bool _isDarkMode = false;
  final Set<String> _bookmarkedIds = {};
  final Set<String> _completedIds = {};
  int _selectedTab = 0;
  bool _disclaimerAccepted = false;

  bool get isLoaded => _isLoaded;
  bool get isDarkMode => _isDarkMode;
  bool get disclaimerAccepted => _disclaimerAccepted;
  int get selectedTab => _selectedTab;
  Set<String> get bookmarkedIds => Set.unmodifiable(_bookmarkedIds);
  Set<String> get completedIds => Set.unmodifiable(_completedIds);

  int get bookmarkCount => _bookmarkedIds.length;
  int get completedCount => _completedIds.length;

  Future<void> load() async {
    _isDarkMode = _storage.isDarkMode;
    _disclaimerAccepted = _storage.disclaimerAccepted;
    _bookmarkedIds
      ..clear()
      ..addAll(_storage.bookmarkedIds);
    _completedIds
      ..clear()
      ..addAll(_storage.completedIds);
    _isLoaded = true;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    if (_isDarkMode == value) return;
    _isDarkMode = value;
    await _storage.setDarkMode(value);
    notifyListeners();
  }

  Future<void> acceptDisclaimer() async {
    _disclaimerAccepted = true;
    await _storage.setDisclaimerAccepted(true);
    notifyListeners();
  }

  void setSelectedTab(int index) {
    if (_selectedTab == index) return;
    _selectedTab = index;
    notifyListeners();
  }

  bool isBookmarked(String id) => _bookmarkedIds.contains(id);
  bool isCompleted(String id) => _completedIds.contains(id);

  Future<void> toggleBookmark(String id) async {
    if (_bookmarkedIds.contains(id)) {
      _bookmarkedIds.remove(id);
    } else {
      _bookmarkedIds.add(id);
    }
    await _storage.saveBookmarks(_bookmarkedIds);
    notifyListeners();
  }

  Future<void> markCompleted(String id) async {
    if (_completedIds.contains(id)) return;
    _completedIds.add(id);
    await _storage.saveCompleted(_completedIds);
    notifyListeners();
  }

  Future<void> resetProgress() async {
    _completedIds.clear();
    await _storage.saveCompleted(_completedIds);
    notifyListeners();
  }
}
