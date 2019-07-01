# HINT Reader

![Hintreader-Logo](https://raw.githubusercontent.com/mobileappdevhm19/apps4students-team-3/gh-pages/wiki/icon_hintreader_yellow.png)

**THE POWER OF TeX, THE CONVENIENCE OF EPUB**

A prototype electronic book reader for the as of now unpublished HINT format.

The main goal of the project was to provide a prototype view for displaying HINT content by embedding a C-based backend into a mobile application, as well as provide modern eReader features users are likely to expect.

![Bookshelf View](https://raw.githubusercontent.com/mobileappdevhm19/HINT-Reader/gh-pages/wiki/screenshots_secondrelease/bookshelfview_newbook.png)&nbsp;
![Book View](https://raw.githubusercontent.com/mobileappdevhm19/HINT-Reader/gh-pages/wiki/screenshots_secondrelease/light_normal.png)

***

## Latest Release

GitHub binaries
https://github.com/mobileappdevhm19/HINT-Reader/releases

Google Play Store (closed beta testing)
https://play.google.com/apps/testing/hintreader.hintreader

***

## Installation Instructions

So far, compilation does not work "out of the box".
Here is a *hopefully* comprehensive list of steps to get the project working.

**Please note,** while multi-platform in theory, the project will not compile for iOS in this sprint.
These instructions are meant for Windows 10, compiling the project for Android 8+, via Android Studio.

### Android NDK

* Install through the Android Studio SDK Manager
* Go to ~/AppData/Local/Android/Sdk/ndk-bundle/toolchains
* Copy the folder aarch64-linux-android-4.9 and rename it mips64el-linux-android

### CMake

* Install Version 3.6.0-rc2

## Set the Windows Environment Variables accordingly

### GLM
* Download https://github.com/g-truc/glm/releases/tag/0.9.9.5
* Move the contained GLM folder to ~/AppData/Local/Android/SDK/ndk-bundle/toolchain/llvm/prebuilt/windowsx86_64/sysroot/usr/include/glm

### SDK Tool Versions

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
