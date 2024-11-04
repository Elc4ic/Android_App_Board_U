import com.google.protobuf.gradle.id
import org.jetbrains.kotlin.gradle.dsl.JvmTarget
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "3.2.2"
    id("war")
    id("io.spring.dependency-management") version "1.1.4"
    id("com.google.protobuf") version "0.9.4"
    kotlin("jvm") version "1.9.23"
    kotlin("plugin.spring") version "2.0.21"
    kotlin("plugin.jpa") version "2.0.21"
    kotlin("plugin.allopen") version "2.0.21"
    application
}


group = "org.example.boardserver"
version = "0.0.1"

repositories {
    mavenCentral()
}

tasks.war {
    manifest {
        attributes["Main-Class"] = application.mainClass
    }
    enabled = true
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
    implementation("org.springframework.boot:spring-boot-starter")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.springframework.boot:spring-boot-starter-actuator")
    implementation("org.springframework.boot:spring-boot-starter-webflux")
    implementation("io.netty:netty-all:4.1.82.Final")

    //tracing/logging
    implementation("io.micrometer:micrometer-tracing-bridge-brave")
    implementation("io.micrometer:micrometer-registry-prometheus")
    implementation("io.zipkin.reporter2:zipkin-reporter-brave")
//    implementation("com.github.loki4j:loki-logback-appender")

    //kotlin
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.8.0")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor")
    implementation("io.projectreactor.kotlin:reactor-kotlin-extensions")

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
    //flyway
    implementation("org.flywaydb:flyway-core")
    //firebase
    implementation("com.google.firebase:firebase-admin:9.0.0")
    implementation("com.google.cloud:google-cloud-pubsub:1.132.1")
    //jwt
    implementation("io.jsonwebtoken:jjwt:0.12.1")
    //database
    runtimeOnly("org.postgresql:postgresql")
    //bcrypt
    implementation("at.favre.lib:bcrypt:0.10.2")
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

allOpen {
    annotation("javax.persistence.Entity")
    annotation("javax.persistence.MappedSuperclass")
    annotation("javax.persistence.Embeddable")
}

noArg {
    annotation("javax.persistence.Entity")
}

tasks.test {
    useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
    compilerOptions {
        jvmTarget.set(JvmTarget.JVM_17)
        freeCompilerArgs.add("-Xjsr305=strict")
    }
}