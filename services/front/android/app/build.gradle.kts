plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // Flutter Gradle Plugin должен идти после Android и Kotlin
    id("dev.flutter.flutter-gradle-plugin")

    // Google Services
    id("com.google.gms.google-services")
}

android {
    namespace = "com.minipong.front"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.minipong.front"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))

    // Firebase Auth
    implementation("com.google.firebase:firebase-auth")

    // Google Play Services Auth (для Google Sign-In)
    implementation("com.google.android.gms:play-services-auth")
}
