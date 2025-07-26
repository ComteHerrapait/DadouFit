// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get welcomeFitBoy => 'Bienvenue, FitBoy !';

  @override
  String get filterLabel => 'Filtres';

  @override
  String get doinsportApiWarning =>
      'Cette application utilise les APIs de doinsport.club';

  @override
  String get generatedByDallE => 'générée avec DALL·E';

  @override
  String get defaultValue => 'valeur par défaut';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsDarkMode => 'Mode sombre';

  @override
  String get settingsColor => 'Couleur';

  @override
  String get settingsColorPick => 'Choisir couleur';

  @override
  String get settingsLocale => 'Langue';

  @override
  String get settingsVersion => 'Version';

  @override
  String get close => 'Fermer';

  @override
  String get open => 'Ouvrir';
}
