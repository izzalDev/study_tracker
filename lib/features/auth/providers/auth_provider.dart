import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _username;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  String? get username => _username;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  static const String _keyIsAuthenticated = 'isAuthenticated';
  static const String _keyUsername = 'username';

  Future<void> checkAuthStatus() async {
    try {
      _isLoading = true;
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      _isAuthenticated = prefs.getBool(_keyIsAuthenticated) ?? false;
      _username = prefs.getString(_keyUsername);

      notifyListeners();
    } catch (e) {
      _setError('Failed to check auth status: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      _setLoading(true);
      _clearError();

      await Future.delayed(const Duration(milliseconds: 800));

      if (username.trim().isEmpty) {
        _setError('Username cannot be empty');
        return false;
      }

      if (username.trim().length < 3) {
        _setError('Username must be at least 3 characters');
        return false;
      }

      if (password.isEmpty) {
        _setError('Password cannot be empty');
        return false;
      }

      if (password.length < 6) {
        _setError('Password must be at least 6 characters');
        return false;
      }

      _isAuthenticated = true;
      _username = username.trim();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyIsAuthenticated, true);
      await prefs.setString(_keyUsername, _username!);

      notifyListeners();
      return true;
    } catch (e) {
      _setError('Login failed: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    try {
      _setLoading(true);

      _isAuthenticated = false;
      _username = null;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyIsAuthenticated);
      await prefs.remove(_keyUsername);

      notifyListeners();
    } catch (e) {
      _setError('Logout failed: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }
}
