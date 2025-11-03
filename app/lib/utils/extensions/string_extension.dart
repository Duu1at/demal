extension StringNull on String? {
  bool get isNullOrEmpty => this == null || this?.isEmpty == true;
  bool get isNotNullOrEmpty => this != null && this?.isEmpty == false;
  bool include(String str) =>
      this?.toLowerCase().contains(str.toLowerCase()) ?? false;
}
