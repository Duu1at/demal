import 'dart:io';

/// Default Spacing in App UI.
abstract class AppSpacing {
  /// The default unit of spacing
  static const double spaceUnit = 16;

  /// xs spacing value (4pt)
  static const double xs = 0.25 * spaceUnit;

  /// sm spacing value (8pt)
  static const double sm = 0.5 * spaceUnit;

  /// md spacing value (12pt)
  static const double md = 0.75 * spaceUnit;

  /// lg spacing value (16pt)
  static const double lg = spaceUnit;

  /// xl spacing value (20pt)
  static const double xl = 1.25 * spaceUnit;

  /// xlg spacing value (24pt)
  static const double xlg = 1.5 * spaceUnit;

  /// xxlg spacing value (32pt)
  static const double xxlg = 2 * spaceUnit;

  /// xxxlg spacing value (40pt)
  static const double xxxlg = 2.5 * spaceUnit;

  /// xxxxlg spacing value (48pt)
  static const double xxxxlg = 3 * spaceUnit;

  /// xxxxxxlg spacing value (56pt)
  static const double xxxxxxlg = 3.5 * spaceUnit;

  /// Bottom space fot spacific platform
  static final double bottomSpace = Platform.isIOS ? 50 : 40;
}
