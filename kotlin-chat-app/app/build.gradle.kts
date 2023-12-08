plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("com.google.gms.google-services")
    id("com.google.dagger.hilt.android")
    id("dagger.hilt.android.plugin")
    id("kotlin-kapt")
    id("com.google.android.libraries.mapsplatform.secrets-gradle-plugin")
}

android {
    namespace = "com.example.kotlin_chat_app"
    compileSdk = 34

    defaultConfig {
        applicationId = "com.example.kotlin_chat_app"
        minSdk = 24
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = "1.8"
    }
    buildFeatures {
        dataBinding = true
        viewBinding = true
    }
}

dependencies {
    implementation(AndroidX.coreKtx)
    implementation(AndroidX.appCompat)
    implementation(AndroidX.constraintLayout)

    implementation(Navigation.navigationFragment)
    implementation(Navigation.navigationUi)

    implementation(Kotlin.serializable)

    implementation(View.material)

    implementation(Firebase.analytics)
    implementation(Firebase.storage)
    implementation(Firebase.firestore)
    implementation(Firebase.database)

    implementation (Dagger.daggerHilt)
    implementation("com.google.android.gms:play-services-maps:18.2.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    kapt (Dagger.hiltCompiler)
    implementation (Dagger.hiltViewModel)
    kapt (Dagger.daggerCompiler)

    androidTestImplementation(AndroidX.testExt)
    androidTestImplementation(AndroidX.testEspresso)
}
