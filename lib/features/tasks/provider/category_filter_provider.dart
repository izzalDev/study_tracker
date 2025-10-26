import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryFilterProvider extends ChangeNotifier {
  final Set<String> _selectedCategories = {};
  final List<String> availableCategories = [
    'Study',
    'Assignment',
    'Exam',
    'Project',
  ];

  Set<String> get selectedCategories => _selectedCategories;
  bool get hasActiveFilter => _selectedCategories.isNotEmpty;

  static const _prefsKey = 'selected_categories';

  Future<void> loadSelectedCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getStringList(_prefsKey);
    if (stored != null) {
      _selectedCategories
        ..clear()
        ..addAll(stored);
      notifyListeners();
    }
  }

  Future<void> _saveSelectedCategories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _selectedCategories.toList());
  }

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
    _saveSelectedCategories();
  }

  void clearFilters() {
    _selectedCategories.clear();
    notifyListeners();
    _saveSelectedCategories();
  }
}
