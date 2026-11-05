import 'package:flutter/material.dart';
import 'verifier_web_view_stub.dart'
    if (dart.library.js_interop) 'verifier_web_view_web.dart';

class VerifierWebView extends StatelessWidget {
  final VoidCallback? onReload;

  const VerifierWebView({
    super.key,
    this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F7FB),
      child: buildVerifierPlatformView(
        key: key,
        onReload: onReload,
      ),
    );
  }

  static void openInNewTab() {
    openVerifierInNewTab();
  }

  static void reloadFrame() {
    reloadVerifierPlatformFrame();
  }
}

