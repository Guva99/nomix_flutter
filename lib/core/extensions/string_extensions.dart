// В любом удобном месте (например, utils/string_extensions.dart)
extension StringCasingExtension on String {
  /// Возвращает строку, где первый символ в верхнем регистре.
  String capitalize() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}
