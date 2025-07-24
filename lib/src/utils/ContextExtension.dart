import 'package:dadoufit/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension LocalizationExt on BuildContext {
  AppLocalizations get translations {
    final l = AppLocalizations.of(this);
    assert(l != null, 'AppLocalizations not found in context');
    return l!;
  }
}
