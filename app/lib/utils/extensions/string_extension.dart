extension StringX on String {
  static final _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  bool get isEmail => _emailRegExp.hasMatch(this);
  bool get isNullOrEmpty => isEmpty;
  bool get isNotNullOrEmpty => isNotEmpty;
  bool include(String str) => toLowerCase().contains(str.toLowerCase());
}

extension StringNull on String? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return this != null && this?.isEmpty == false;
  }

  bool include(String str) {
    return this?.toLowerCase().contains(str.toLowerCase()) ?? false;
  }

  String get lastFour {
    if ((this?.length ?? 0) < 4) return this ?? '';
    return this?.substring((this?.length ?? 0) - 4) ?? '';
  }
}
