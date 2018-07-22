#!/bin/sh
./gradlew :sdktool:copyJar
./gradlew :channel:channel_demo:copyJar
./gradlew :platform:platform_android:copyJar
./gradlew :platform:platform_unity:copyJar
