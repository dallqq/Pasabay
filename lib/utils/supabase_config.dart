/// Configuration for Supabase backend.
/// 
/// You can configure these values in two ways:
/// 1. Replace the default placeholder strings below with your project URL & Anon key.
/// 2. Provide them at build/run time via --dart-define:
///    flutter run --dart-define=SUPABASE_URL=your_url --dart-define=SUPABASE_ANON_KEY=your_key
class SupabaseConfig {
  /// Supabase Project URL (e.g. 'https://your-project.supabase.co')
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://czodfzjqkvpicbnhtqhv.supabase.co',
  );

  /// Supabase Anonymous Public API Key (anon key)
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN6b2Rmempxa3ZwaWNibmh0cWh2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA3MDA2MDAsImV4cCI6MjA3NjI3NjYwMH0.jmegrTiS_SssfQrAqc66xGLn3LIz12tMdHeIu3WYYfQ',
  );
}
