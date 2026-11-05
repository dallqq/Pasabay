import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../verifier/screens/verifier_dashboard_screen.dart';
import '../../verifier/screens/verifier_login_screen.dart';
import '../../services/auth_service.dart';

Widget buildVerifierPlatformView({Key? key, VoidCallback? onReload}) {
  return const _NativeVerifierWrapper();
}

class _NativeVerifierWrapper extends StatelessWidget {
  const _NativeVerifierWrapper();

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();
    return StreamBuilder<AuthState>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data?.session != null) {
          return FutureBuilder<bool>(
            future: authService.isVerifier(),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              if (roleSnapshot.data == true) {
                return const VerifierDashboardScreen();
              }

              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.block, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text(
                        'Access Denied (Verifier Role Required)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => authService.signOut(),
                        child: const Text('Sign Out'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const VerifierLoginScreen();
      },
    );
  }
}

void openVerifierInNewTab() async {
  final uri = Uri.parse('verifier_dashboard.html');
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

void reloadVerifierPlatformFrame() {
  // No-op for native fallback
}

