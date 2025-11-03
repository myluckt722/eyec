plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.eyec"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.eyec"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true // ✅ Required for flutter_local_notifications
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

dependencies {
    implementation(kotlin("stdlib"))
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4") // ✅ Required
}

flutter {
    source = "../.."
}
