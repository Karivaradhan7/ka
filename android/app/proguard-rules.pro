# Flutter-specific ProGuard rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep AndroidX classes (Important for Jetpack libraries)
-keep class androidx.** { *; }
-dontwarn androidx.**

# Keep the main Flutter activity
-keep class com.example.waste_management.** { *; }

# Prevent obfuscation of Glide image loading library (if used)
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**

# Core desugaring support (For Java 8+ features)
-dontwarn java.time.**
-keep class java.time.** { *; }
