import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:localization/constant/global_context.dart';

class L10n {
  static final t = AppLocalizations.of(globalContext)!;
  static final localeName = AppLocalizations.of(globalContext)!.localeName;
}
