#!/bin/sh
./gradlew :sdktool:copyJar
./gradlew :channel:channel_demo:copyJar
./gradlew :channel:channel_uc:copyJar
./gradlew :platform:platform_android:copyJar
./gradlew :platform:platform_unity:copyJar
./gradlew :platform:platform_cocos2dx:copyJar