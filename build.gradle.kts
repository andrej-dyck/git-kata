import org.jetbrains.kotlin.gradle.plugin.KotlinSourceSet
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.4.30"
}

allprojects {
    group = "git.kata"
    version = "1.0"

    repositories { mavenLocal(); jcenter() }
}

subprojects {
    when (name) {
        "exercise" -> {
            /* 🔨 Kotlin build */
            apply(plugin = "org.jetbrains.kotlin.jvm")

            tasks.withType<KotlinCompile>().configureEach {
                kotlinOptions.jvmTarget = "1.8"
            }

            sourceSets.getByName("main") {
                withConvention(KotlinSourceSet::class) {
                    kotlin.srcDirs("src/")
                }
            }

            /* ✔ Unit Tests with JUnit5 */
            dependencies {
                testImplementation(platform("org.junit:junit-bom:5.7.0"))
                testImplementation("org.junit.jupiter:junit-jupiter")
            }

            tasks.test {
                useJUnitPlatform { excludeEngines("junit-vintage") }
            }

            sourceSets.getByName("test") {
                withConvention(KotlinSourceSet::class) {
                    kotlin.srcDirs("test/")
                }
            }
        }
        else -> /* 📜 Custom tasks */ tasks {

            register<Exec>("${project.name}-init") {
                group = "kata-exercises"
                commandLine("sh", "./init.sh")
            }
        }
    }
}

/* 🎁 Gradle wrapper */
tasks.withType<Wrapper> {
    gradleVersion = "6.8"
    distributionType = Wrapper.DistributionType.BIN
}