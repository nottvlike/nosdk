#!/bin/sh
./gradlew :sdktool:copyJar
./gradlew :channel_demo:copyJar
./gradlew :platform_android:copyJar
./gradlew :platform_unity:copyJar
