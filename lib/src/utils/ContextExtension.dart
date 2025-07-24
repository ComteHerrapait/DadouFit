import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizationExt on BuildContext {
  AppLocalizations get translations {
    final l = AppLocalizations.of(this);
    assert(l != null, 'AppLocalizations not found in context');
    return l!;
  }
}
