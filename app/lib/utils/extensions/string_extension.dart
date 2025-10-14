final _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

extension StringX on String {
  String get obscureFirstNumbers => '${'*' * (length - 4)}${substring(length - 4)}';
  bool get isSvg => endsWith('.svg');
  String get removeSymbols => replaceAll(' ', '').replaceAll(')', '').replaceAll('(', '').replaceAll('-', '');
  bool get isEmail => _emailRegExp.hasMatch(this);

  String get obscureEmail {
    final parts = split('@');
    String email = '';
    email = parts.first.substring(0, 1) + ('*' * (parts.first.substring(1).length - 1));
    email = "$email${parts.first.substring(parts.first.length - 1)}@${parts.last}";
    return email;
  }

  String formatHtmlString() {
    return replaceAll("<p>", "\n\n") // Paragraphs
        .replaceAll("<br>", "\n") // Line Breaks
        .replaceAll("&quot;", "\"") // Quote Marks
        .replaceAll("&apos;", "'") // Apostrophe
        .replaceAll("&lt;", ">") // Less-than Comparator (Strip Tags)
        .replaceAll("&gt;", "<") // Greater-than Comparator (Strip Tags)
        .trim(); // Whitespace
  }

  String get amountToTransfer {
    final val = toAmount;
    return val == 0 ? '0' : (val * 100).toInt().toString();
  }

  double get toAmount => double.tryParse(replaceAll(',', '.').trim()) ?? 0;

  String get urlWithoutProtocol => Uri.parse(this).host;

  bool get isValidInn {
    final regexp = RegExp(r'^[0-9]*$');
    if (isEmpty) return false;
    if (length != 14 || (!startsWith('1') && !startsWith('2'))) {
      return false;
    } else if (!regexp.hasMatch(this)) {
      return false;
    } else {
      return true;
    }
  }
}

extension StringNull on String? {
  bool get isNullOrEmpty => this == null || this?.isEmpty == true;
  bool get isNotNullOrEmpty => this != null && this?.isEmpty == false;
  bool include(String str) => this?.toLowerCase().contains(str.toLowerCase()) ?? false;
}
