plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.waste_management"
    compileSdk = 35  // Latest stable version

    defaultConfig {
        applicationId = "com.example.waste_management"
        minSdk = 23  // Set minSdk to 23 for better device compatibility
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"

        multiDexEnabled = true  // Enables MultiDex support for large projects
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17  // ✅ Java 17 compatibility
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true  // ✅ Enables core library desugaring
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    ndkVersion = "27.0.12077973"
}

flutter {
    source = "../.."
}

dependencies {
    implementation("androidx.multidex:multidex:2.0.1")

    // ✅ Core Library Desugaring (Fixes Java 8+ Issues)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")

    // ✅ Flutter Dependencies (Ensure Flutter Compatibility)
    implementation("androidx.core:core-ktx:1.12.0")
}
