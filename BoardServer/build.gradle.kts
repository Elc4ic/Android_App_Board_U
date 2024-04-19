import com.google.protobuf.gradle.id
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "3.2.2"
    id("io.spring.dependency-management") version "1.1.4"
    id("com.google.protobuf") version "0.9.4"
    kotlin("jvm") version "1.9.23"
    kotlin("plugin.spring") version "1.9.23"
    kotlin("plugin.jpa") version "1.9.23"
    application
}

group = "org.example.boardserver"
version = "0.0.1"

repositories {
    mavenCentral()
}

tasks.jar {
    manifest {
        attributes["Main-Class"] = application.mainClass
    }
    enabled = true
}

val protobuf = "3.25.3"
val grpc = "1.62.2"
val okhttp = "4.12.0"
val grpcKotlinPlugin = "1.4.1"
val grpcServerVersion = "2.15.0.RELEASE"

dependencies {
    //spring
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    //kotlin
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.8.0")
    //grpc
    implementation("io.grpc:grpc-kotlin-stub:${grpcKotlinPlugin}")
    implementation("io.grpc:grpc-protobuf:${grpc}")
    implementation("io.grpc:protoc-gen-grpc-java:${grpc}")
    implementation("io.grpc:protoc-gen-grpc-kotlin:${grpcKotlinPlugin}")
    implementation("com.google.protobuf:protoc:${protobuf}")
    implementation("com.google.protobuf:protobuf-kotlin:${protobuf}")
    implementation("net.devh:grpc-server-spring-boot-starter:${grpcServerVersion}")
    //annotation
    implementation("javax.annotation:javax.annotation-api:1.3.2")
    //database
    runtimeOnly("org.postgresql:postgresql")
    //test
    testImplementation("org.springframework.boot:spring-boot-starter-test")
    testImplementation(platform("org.junit:junit-bom:5.9.1"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testImplementation(kotlin("test"))
}

protobuf {
    protoc {
        artifact = "com.google.protobuf:protoc:3.21.12"
    }
    plugins {
        id("grpc") {
            artifact = "io.grpc:protoc-gen-grpc-java:1.52.1"
        }
        id("grpckt") {
            artifact = "io.grpc:protoc-gen-grpc-kotlin:1.3.0:jdk8@jar"
        }
    }
    generateProtoTasks {
        all().forEach {
            it.plugins {
                id("grpc")
                id("grpckt")
            }
            it.builtins {
                id("kotlin")
            }
        }
    }
}

application {
    mainClass.set("com.example.boardserver.ServerApplicationKt")
}

springBoot {
    mainClass.set("com.example.boardserver.ServerApplicationKt")
}

tasks.test {
    useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = JavaVersion.VERSION_17.toString()
    }
}