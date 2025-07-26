import 'dart:ui';

import 'package:dadoufit/src/js/js_interface.dart';

import 'js_fake.dart' if (dart.library.html) 'js_real.dart';

export 'js_interface.dart';

// The goal of this technic is to avoid import javascript-specific code into other builds.
// The conditionnal import allows to import a JavascriptImplementation or the other according to context.
class Javascript {
  final JavascriptInterface _impl;

  Javascript() : _impl = JavascriptImplementation();

  void setMetaThemeColor(Color color) {
    _impl.setMetaThemeColor(color);
  }
}
