import 'package:shared_preferences/shared_preferences.dart';

/// Persists user preferences and progress locally on device.
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;

  static const _darkModeKey = 'dark_mode';
  static const _bookmarksKey = 'bookmarks';
  static const _completedKey = 'completed';
  static const _disclaimerAcceptedKey = 'disclaimer_accepted';

  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  bool get isDarkMode => _prefs.getBool(_darkModeKey) ?? false;

  Future<void> setDarkMode(bool value) => _prefs.setBool(_darkModeKey, value);

  bool get disclaimerAccepted =>
      _prefs.getBool(_disclaimerAcceptedKey) ?? false;

  Future<void> setDisclaimerAccepted(bool value) =>
      _prefs.setBool(_disclaimerAcceptedKey, value);

  Set<String> get bookmarkedIds =>
      _prefs.getStringList(_bookmarksKey)?.toSet() ?? {};

  Future<void> saveBookmarks(Set<String> ids) =>
      _prefs.setStringList(_bookmarksKey, ids.toList());

  Set<String> get completedIds =>
      _prefs.getStringList(_completedKey)?.toSet() ?? {};

  Future<void> saveCompleted(Set<String> ids) =>
      _prefs.setStringList(_completedKey, ids.toList());
}
