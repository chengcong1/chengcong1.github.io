---
title: VS Code上手体验
description: VS Code上手体验
date: 2025-06-16
slug: use_vscode
categories:
    - vscode
draft: false # 草稿
---

## 介绍
VS Code是一款开源的代码编辑器，基于Electron 框架构建，支持Windows、MacOS和Linux。
VS Code 开源地址：https://github.com/microsoft/vscode
## 安装
VS Code下载地址：https://code.visualstudio.com/download
## 插件
插件下载地址：https://marketplace.visualstudio.com/
### 常用插件
- Chinese (Simplified) (简体中文)：适用于 VS Code 的中文（简体）语言包
- Error Lens：将错误信息显示在代码行后面
- Even Better TOML：TOML 配置文件语法高亮


### 远程开发
- Remote - SSH
依赖：`Remote - SSH: Editing Configuration Files`、`Remote Explorer`

### golang环境
- Go：golang.go

### vue3环境


### 代码补全
- Lingma - Alibaba Cloud AI Coding Assistant：阿里云提供的智能编码辅助工具，提供 代码智能生成、智能问答、多文件修改、编程智能体 等能力
- GitHub Copilot：微软提供
- Comate BaiduComate：文心快码，百度提供

### AI写代码
- Cline：AI助手
- Cline-Chinese：Cline中文汉化版
- CodeBuddy：腾讯云自研的一款开发编程提效辅助工具

## 配置
### 禁用更新
禁用扩展更新：
设置--用户--功能--扩展--Auto Check Updates(适用于所有配置文件)--取消勾选
设置--用户--功能--扩展--Auto Update(适用于所有配置文件)--取消勾选

禁用VS Code更新：
设置--用户--应用程序--启用在windows上后台下载和安装新的VS Code版本--取消勾选

## 基于VS Code的其他编辑器
### Lingma IDE
Lingma IDE 是基于 VS Code 开源版本构建的智能代码编辑器，全面集成智能编码助手的能力，开箱即用更简单，无需安装插件即可享受高效、智能的编程体验。
下载地址：https://lingma.aliyun.com/download
目前登陆后免费使用
### VSCodium
VSCodium 是微软流行的 Visual Studio Code 编辑器的一个分支。它与 VS Code 完全相同，唯一不同的是，VSCodium 不跟踪你的使用数据。
VSCodium不能使用微软的`Remote - SSH`插件
### Cursor
Cursor是一款AI 代码编辑器。
试用过后收费
### Comate
百度IDE