# Flutter specific
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Play Store split compat (required by Flutter)
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }

# flutter_secure_storage
-keep class com.it_nomads.fluttersecurestorage.** { *; }

# syncfusion_flutter_pdf
-keep class com.syncfusion.** { *; }

# Keep model classes used by JSON serialization
-keep class com.example.paperpal.** { *; }

# Keep generated R8 missing rules
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
