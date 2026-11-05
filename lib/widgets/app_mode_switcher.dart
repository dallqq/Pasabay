import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'responsive_wrapper.dart';
import 'verifier_view/verifier_web_view.dart';

enum AppMode {
  mainApp,
  verifierWebsite,
}

/// A wrapper that displays either the Main App or the Verifier Website one at a time,
/// with the logo on the left and the mode switcher toggle on the right.
class AppModeSwitcher extends StatefulWidget {
  final Widget child;

  const AppModeSwitcher({
    super.key,
    required this.child,
  });

  @override
  State<AppModeSwitcher> createState() => _AppModeSwitcherState();
}

class _AppModeSwitcherState extends State<AppModeSwitcher> {
  AppMode _currentMode = AppMode.mainApp;
  int _verifierSessionKey = 0;

  void _switchMode(AppMode mode) {
    if (_currentMode != mode) {
      setState(() {
        _currentMode = mode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Material(
            color: const Color(0xFF0B0F19),
            child: SafeArea(
              top: true,
              bottom: false,
              child: Column(
                children: [
                  // Top Navigation Bar
                  _buildTopBar(),

                  // Content Area (Displays one view at a time while preserving state)
                  Expanded(
                    child: IndexedStack(
                      index: _currentMode == AppMode.mainApp ? 0 : 1,
                      children: [
                        // Mode 0: Main User App (Traveler & Requester inside ResponsiveWrapper)
                        ResponsiveWrapper(
                          child: widget.child,
                        ),

                        // Mode 1: Verifier Website (Full width/height portal)
                        VerifierWebView(
                          key: ValueKey('verifier-$_verifierSessionKey'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A), // Midnight slate
        border: Border(
          bottom: BorderSide(
            color: Color(0x1AFFFFFF),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Logo Only (Without Pasabay word)
          Image.asset(
            AppConstants.smallLogoPath,
            height: 32,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00AAF3), Color(0xFF0077B6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.local_shipping_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          // Right: Only Main App and Verifier Website Buttons
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0x33FFFFFF),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToggleItem(
                  label: 'Main App',
                  isSelected: _currentMode == AppMode.mainApp,
                  onTap: () => _switchMode(AppMode.mainApp),
                ),
                _buildToggleItem(
                  label: 'Verifier Website',
                  isSelected: _currentMode == AppMode.verifierWebsite,
                  onTap: () => _switchMode(AppMode.verifierWebsite),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF00AAF3) : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF00AAF3).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF94A3B8),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
