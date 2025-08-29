---
title: switch
description: switch
date: 2025-08-29
slug: switch
categories:
    - switch
draft: false # 草稿
---

## 模拟器下载
~~**suyu**~~
~~官网：https://suyu.dev/~~
~~github：https://github.com/suyu-emu/suyu~~
~~**sudachi**~~
github：https://github.com/sudachi-emu/sudachi/
**Ryujinx**~~
官网：https://ryujinx.org/
github：https://github.com/Ryujinx/Ryujinx
~~(不含移动版)~~
suyu系列：suyu、sudachi已经停止了，目前还有torzu存在
Ryujinx系列：Ryujinx已停止开发
### torzu
镜像：https://notabug.org/litucks/torzu 只是代码镜像可能会停用
torzu开发者不会提供编译好的二进制程序，而是需要自行编译，好在github上有人已编译的
~~地址1：https://github.com/leonewton253/torzu~~
地址2：https://github.com/ong19th/Torzu

## 秘钥与固件
### 下载
Prodkeys官网：https://prodkeys.net/
Yuzu Emu：https://emuyuzu.com/yuzu-prod-keys/
固件下载1：https://github.com/THZoria/NX_Firmware/releases/
固件下载2：https://www.gamer520.com/61541.html
固件安装：https://prodkeys.net/yuzu-firmware-v3/
### 安装
修改yuzu文件夹路径：
启动yuzu-文件-打开yuzu文件夹(默认为C:\Users\{{用户名}}\AppData\Roaming\yuzu)-将yuzu目录复制到yuzu.exe同级目录下并修改名称为user-关闭yuzu-删除\AppData\Roaming\yuzu 文件夹。

固件目录：固件解压后放在 nand\system\Contents\registered\ 目录下

密钥目录：密钥prod.keys、title.keys放在keys目录下

完成后验证： 工具-验证已安装内容的完整性。
## 萝卜驱动
Mesa Turnip 驱动下载(安卓)
github：https://github.com/K11MCH1/AdrenoToolsDrivers/releases
## 依赖安装
windows：VC++

## 运行游戏
### 游戏下载
gamer520：https://www.gamer520.com/
### 补丁安装
补丁下载：
https://github.com/yuzu-mirror/yuzu-mod-archive
https://github.com/amakvana/SwitchEmuModDownloader
https://github.com/StevensND/switch-port-mods
### 模拟器设置

## 参考链接
yuzu模拟器安装使用教程(持续更新)：https://www.bilibili.com/read/cv15405863/

## 如何编译torzu
### build-for-windows
https://notabug.org/litucks/torzu/src/master/build-for-windows.md
需要：
Visual Studio Community 2022：https://visualstudio.microsoft.com/zh-hans/downloads/
CMake：https://cmake.org/download/
Vulkan SDK：https://vulkan.lunarg.com/sdk/home#windows
Python：https://www.python.org/downloads/windows/
Git for Windows：https://gitforwindows.org/ When installing Git, include it in your system PATH by choosing the "Git from the command line and also from 3rd-party software" option.
安装Git for Windows时选 "Git from the command line and also from 3rd-party software"
```shell
# from Notabug repo
git clone --depth 1 https://notabug.org/litucks/torzu.git
# git -c http.proxy=socks5h://127.0.0.1:9050 clone --depth 1 http://vub63vv26q6v27xzv2dtcd25xumubshogm67yrpaz2rculqxs7jlfqad.onion/torzu-emu/torzu.git
cd torzu
# 下载子模块，这一步也比较重要
git submodule update --init --recursive
mkdir build
cd build
cmake .. -G "Visual Studio 17 2022" -A x64 -DYUZU_TESTS=OFF
# 这一步经常会遇到错误，可以更换稍微旧点的cmake版本重试，部分包没下载好，请多次重试并有耐心。
cmake --build . --config Release
```
编译完成后可在build/bin/Release目录下找到
```shell
cd bin
cd Release
mkdir user
```
### debian12+编译安卓apk
```
# 源码
git clone --depth 1 --recursive https://notabug.org/litucks/torzu.git
cd torzu
git submodule update --init --recursive
# 依赖
sudo apt-get update
sudo apt-get install -y sdkmanager openjdk-17-jdk build-essential curl git pkg-config glslang-tools zip
sudo sdkmanager "ndk;26.3.11579264" "platforms;android-34" "build-tools;34.0.0" "cmake;3.22.1" "platform-tools;34.0.5"
sudo update-alternatives --config java # Select Java 17 here if possible
# 构建
./externals/vcpkg/bootstrap-vcpkg.sh -disableMetrics
export ANDROID_HOME=/opt/android-sdk
cd src/android
./gradlew assembleRelease
```
APK 将位于src/android/app/build/outputs/apk/mainline/release/app-mainline-release.apk
Mesa Turnip driver ：https://github.com/K11MCH1/AdrenoToolsDrivers/releases
sudo sdkmanager 安装的工具或SDK可以在 `/usr/lib/android-sdk` (ubuntu)下找找看。
这里编译失败了。


## 更新
2025年1月11日：