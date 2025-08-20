allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

plugins {
    // Flutter manages these versions
    id("com.android.application") apply false
    id("org.jetbrains.kotlin.android") apply false

    // Flutter Gradle Plugin
    id("dev.flutter.flutter-gradle-plugin") apply false

    // Google Services plugin – you set this one
    id("com.google.gms.google-services") version "4.4.3" apply false
}



