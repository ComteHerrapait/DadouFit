import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

@JS('setMetaThemeColor')
external void setMetaThemeColor(JSString message);

void setMetaThemeColorWrapper(Color newColor) {
  setMetaThemeColor(newColor.toHexString.toString().toJS);
}
