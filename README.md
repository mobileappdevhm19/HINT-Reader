
[![Coverage Status](https://coveralls.io/repos/github/mobileappdevhm19/HINT-Reader/badge.svg?branch=master)](https://coveralls.io/github/mobileappdevhm19/HINT-Reader?branch=master)

# openGL Backend Dependencies

So far, compilation does not work "out of the box".
Here is a *hopefully* comprehensive list of steps to get the project working.

**Please note,** while multi-platform in theory, the project will not compile for iOS in this sprint.
These instructions are meant for Windows 10, compiling the project for Android 8+, via Android Studio.

## Android NDK

* Install through the Android Studio SDK Manager
* Go to ~/AppData/Local/Android/Sdk/ndk-bundle/toolchains
* cp aarch64-linux-android-4.9 mips64el-linux-android

## CMake

* Install Version 3.6.0-rc2

## Set the Windows Environment Variables accordingly

## GLM
* download https://github.com/g-truc/glm/releases/tag/0.9.9.5
* mv to ~/AppData/Local/Android/SDK/ndk-bundle/toolchain/llvm/prebuilt/windowsx86_64/sysroot/usr/include/glm


***


## SDK Tool Versions

* Android SDK Build-Tools 29
  * 26.0.2
  * 28.0.3
  * 29.0.0
  
* LLDB
  * 3.1
  
* CMake
  * 3.6.4111459

* Android Emulator
* Android SDK Platform-Tools
* Android SDK Tools
* Documentation for Android SDK
* Google USB Driver
* Intelx86 Emulator Accelerator (HAXM Installer)
* NDK

* Support Repository
  * ConstraintLayout for Android
    * 1.0.2
  * Solver for ConstraintLayout
    * 1.0.2

* Android Support Repository
* Google Repository
