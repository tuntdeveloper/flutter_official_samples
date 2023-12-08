interface Libraries {
    val components: List<String>
}


object Firebase {
    const val analytics = "com.google.firebase:firebase-analytics:21.5.0"
    const val firestore = "com.google.firebase:firebase-firestore:24.9.1"
    const val storage = "com.google.firebase:firebase-storage:20.3.0"
    const val database = "com.google.firebase:firebase-database:20.3.0"
}

object Kotlin {

    object Versions {
        const val kotlin = "1.4.21"
        const val coroutines = "1.4.2"
    }

    const val stdlib = "org.jetbrains.kotlin:kotlin-stdlib:${Versions.kotlin}"
    const val coroutinesAndroid =
        "org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.coroutines}"
    const val coroutinesCore =
        "org.jetbrains.kotlinx:kotlinx-coroutines-core:${Versions.coroutines}"
    const val coroutineTest =
        "org.jetbrains.kotlinx:kotlinx-coroutines-test:${Versions.coroutines}"
    const val serializable = "org.jetbrains.kotlinx:kotlinx-serialization-json:1.6.0"

}


object Dagger : Libraries {

    const val daggerHilt = "com.google.dagger:hilt-android:2.40.1"
    const val daggerCompiler = "com.google.dagger:hilt-android-compiler:2.37"
    const val hiltCompiler = "androidx.hilt:hilt-compiler:1.1.0"
    const val hiltViewModel ="androidx.hilt:hilt-lifecycle-viewmodel:1.0.0-alpha03"

    override val components: List<String> = listOf(daggerHilt, hiltCompiler, daggerCompiler, hiltViewModel)
}

object Navigation : Libraries {

    object Versions {
        const val navigation = "2.3.3"
    }

    const val navigationFragment =
        "androidx.navigation:navigation-fragment-ktx:${Versions.navigation}"
    const val navigationUi = "androidx.navigation:navigation-ui-ktx:${Versions.navigation}"

    override val components: List<String>
        get() = listOf(navigationFragment, navigationUi)
}


object View : Libraries {

    private object Versions {
        const val material = "1.10.0"
        const val recyclerView = "1.2.0-beta01"
        const val constraintLayout = "2.0.4"
        const val swipeRefresh = "1.1.0"
        const val viewPager = "1.0.0"

    }

    const val material = "com.google.android.material:material:${Versions.material}"
    const val constraintLayout =
        "androidx.constraintlayout:constraintlayout:${Versions.constraintLayout}"
    const val viewPager = "androidx.viewpager2:viewpager2:${Versions.viewPager}"
    const val swipeRefresh =
        "androidx.swiperefreshlayout:swiperefreshlayout:${Versions.swipeRefresh}"
    const val recyclerView = "androidx.recyclerview:recyclerview:${Versions.recyclerView}"

    override val components = listOf(
        material, constraintLayout, viewPager, swipeRefresh,
        recyclerView
    )
}


object AndroidX : Libraries {
    private object Versions {
        const val androidx_core = "1.3.2"
        const val appCompat = "1.6.1"
        const val lifeCycle = "2.3.0-alpha03"
        const val preferences = "1.1.1"
        const val legacy = "1.0.0"
        const val work = "2.5.0"
        const val paging = "2.1.2"
        const val fragment = "1.3.0-alpha06"

        const val archCoreTesting = "2.1.0"
        const val coreKtxTest = "1.3.0"
        const val testExt = "1.1.2"
        const val testRules = "1.3.0"
    }

    const val coreKtx = "androidx.core:core-ktx:${Versions.androidx_core}"
    const val appCompat = "androidx.appcompat:appcompat:${Versions.appCompat}"
    const val liveData = "androidx.lifecycle:lifecycle-livedata-ktx:${Versions.lifeCycle}"
    const val viewModel =
        "androidx.lifecycle:lifecycle-viewmodel-ktx:${Versions.lifeCycle}"
    const val lifeCycleCommon =
        "androidx.lifecycle:lifecycle-common-java8:${Versions.lifeCycle}"
    const val legacySupport = "androidx.legacy:legacy-support-v4:${Versions.legacy}"
    const val preferences = "androidx.preference:preference-ktx:${Versions.preferences}"

    const val workManager = "androidx.work:work-runtime-ktx:${Versions.work}"
    const val paging = "androidx.paging:paging-runtime-ktx:${Versions.paging}"

    const val archCoreTesting = "androidx.arch.core:core-testing:${Versions.archCoreTesting}"
    const val coreKtxTest = "androidx.test:core-ktx:${Versions.coreKtxTest}"
    const val testExt = "androidx.test.ext:junit-ktx:${Versions.testExt}"
    const val testRules = "androidx.test:rules:${Versions.testRules}"
    const val fragmentTesting = "androidx.fragment:fragment-testing:${Versions.fragment}"
    const val constraintLayout =
        "androidx.constraintlayout:constraintlayout:${Versions.androidx_core}"

    const val testEspresso = "androidx.test.espresso:espresso-core:3.5.1"

    override val components: List<String>
        get() = listOf(coreKtx, viewModel, appCompat, lifeCycleCommon, liveData, preferences)
}