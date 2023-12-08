buildscript {
    dependencies {
        classpath("com.google.gms:google-services:4.4.0")
        classpath("org.jetbrains.kotlin:kotlin-serialization:1.9.20")
        classpath ("com.google.dagger:hilt-android-gradle-plugin:2.44")
    }
}
// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
    id("com.android.application") version "8.1.3" apply false
    id("org.jetbrains.kotlin.android") version "1.9.0" apply false
    id("com.android.library") version "8.1.3" apply false
    id("org.jetbrains.kotlin.jvm") version "1.9.20"
    id("org.jetbrains.kotlin.plugin.serialization") version "1.9.20"
    id("com.google.android.libraries.mapsplatform.secrets-gradle-plugin") version "2.0.1" apply false
}

