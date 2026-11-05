// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;
import 'package:flutter/material.dart';

bool _isViewTypeRegistered = false;
const String _viewTypeId = 'verifier-dashboard-iframe';

Widget buildVerifierPlatformView({Key? key, VoidCallback? onReload}) {
  if (!_isViewTypeRegistered) {
    ui_web.platformViewRegistry.registerViewFactory(_viewTypeId, (int viewId) {
      final iframe = web.HTMLIFrameElement()
        ..src = 'verifier_dashboard.html'
        ..id = 'verifier-dashboard-frame'
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.backgroundColor = '#f5f7fb';
      return iframe;
    });
    _isViewTypeRegistered = true;
  }

  return HtmlElementView(
    key: key,
    viewType: _viewTypeId,
  );
}

void openVerifierInNewTab() {
  web.window.open('verifier_dashboard.html', '_blank');
}

void reloadVerifierPlatformFrame() {
  final element = web.document.getElementById('verifier-dashboard-frame');
  if (element != null && element is web.HTMLIFrameElement) {
    element.src = 'verifier_dashboard.html?t=${DateTime.now().millisecondsSinceEpoch}';
  }
}

