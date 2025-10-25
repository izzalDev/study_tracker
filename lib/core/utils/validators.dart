class Validators {
  Validators._();

  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName is required'
          : 'This field is required';
    }
    return null;
  }

  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (value.trim().length < minLength) {
      return fieldName != null
          ? '$fieldName must be at least $minLength characters'
          : 'Must be at least $minLength characters';
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    if (value.trim().length > maxLength) {
      return fieldName != null
          ? '$fieldName must not exceed $maxLength characters'
          : 'Must not exceed $maxLength characters';
    }
    return null;
  }

  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }

  static String? taskTitle(String? value) {
    return combine(value, [
      (v) => required(v, fieldName: 'Title'),
      (v) => minLength(v, 3, fieldName: 'Title'),
      (v) => maxLength(v, 50, fieldName: 'Title'),
    ]);
  }

  static String? taskDescription(String? value) {
    return combine(value, [
      (v) => required(v, fieldName: 'Description'),
      (v) => minLength(v, 10, fieldName: 'Description'),
      (v) => maxLength(v, 500, fieldName: 'Description'),
    ]);
  }
}
