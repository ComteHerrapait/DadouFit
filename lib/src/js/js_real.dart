import 'dart:js_interop';

import 'package:dadoufit/src/js/js_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@JS('setMetaThemeColor')
external void _setMetaThemeColor(JSString message);

class JavascriptImplementation implements JavascriptInterface {
  @override
  void setMetaThemeColor(Color color) {
    _setMetaThemeColor(color.toHexString.toString().toJS);
  }
}
