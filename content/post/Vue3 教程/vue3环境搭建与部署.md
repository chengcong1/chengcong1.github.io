---
title: vue3环境搭建与部署
description: vue3环境搭建与部署
date: 2025-06-25
slug: vue3_build
# image: image.jpg
categories:
    - golang
    - vue3
draft: false # 草稿
---

## vue3环境搭建
### 安装node.js
需要安装18.3或更高版本的 Node.js

windows安装：https://nodejs.cn/download

debian 安装：`sudo apt install nodejs npm`(仅尝试)

检查安装：`node -v`
## 创建一个 Vue 应用
vite + vue3 + typescript
```
# npm 6.x
npm create vite@latest my-vue-app --template vue

# npm 7+, extra double-dash is needed:
npm create vite@latest my-vue-app -- --template vue

# yarn
yarn create vite my-vue-app --template vue

# pnpm
pnpm create vite my-vue-app --template vue

```
运行：`npm run dev`


## vue3+golang部署样例
以 gin-vue-admin为例
### 前后端分离
```
# 克隆项目
git clone https://github.com/flipped-aurora/gin-vue-admin.git

# server项目:

## 进入server文件夹
cd server

## 使用 go mod 并安装go依赖包
go generate

## 运行
go run . 

# web项目:
## 进入web文件夹
cd web

## 安装依赖
npm install

## 启动web项目
npm run serve

```
### 非nginx部署代理(gin)
在gin-vue-admin\server\initialize\router.go文件中按照文件中的注释配置。
```
// 如果想要不使用nginx代理前端网页，可以修改 web/.env.production 下的
// VUE_APP_BASE_API = /
// VUE_APP_BASE_PATH = http://localhost
// 然后执行打包命令 npm run build。再打开下面3行注释，将编译好的dist目录下的文件复制到server目录下
// Router.StaticFile("/favicon.ico", "./dist/favicon.ico")
// Router.Static("/assets", "./dist/assets") // dist里面的静态资源
// Router.StaticFile("/", "./dist/index.html") // 前端网页入口页面
```
如果运行后static找不到文件，则：
```
# 注释
// Router.StaticFile("/", "./dist/index.html") // 前端网页入口页面
# 添加
Router.NoRoute(func(c *gin.Context) {
		data, err := os.ReadFile("./dist/index.html")
		if err != nil {
			c.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		c.Data(http.StatusOK, "text/html; charset=utf-8", data)
	})
```
### 使用embed嵌入资源文件
#### gin+vue
请访问：[go embed 实现gin + vue静态资源嵌入](https://blog.csdn.net/u010280075/article/details/130872405)

如果将dist目录放到public目录下：
```
# server/public.go
package public

import (
	"embed"
)

//go:embed dist
var StaticFile embed.FS
# server\initialize\router.go
// Router.StaticFile("/favicon.ico", "./dist/favicon.ico")
// Router.Static("/assets", "./dist/assets") // dist里面的静态资源
// Router.StaticFile("/", "./dist/index.html") // 前端网页入口页面
Router.Use(Serve("/", EmbedFolder(public.StaticFile, "dist")))
	Router.NoRoute(func(c *gin.Context) {
		data, err := public.StaticFile.ReadFile("dist/index.html")
		if err != nil {
			c.AbortWithError(http.StatusInternalServerError, err)
			return
		}
		c.Data(http.StatusOK, "text/html; charset=utf-8", data)
	})
# 其他未修改直接复制博客内函数即可
const INDEX = "index.html"

type ServeFileSystem interface {
	http.FileSystem
	Exists(prefix string, path string) bool
}

type localFileSystem struct {
	http.FileSystem
	root    string
	indexes bool
}

func LocalFile(root string, indexes bool) *localFileSystem {
	return &localFileSystem{
		FileSystem: gin.Dir(root, indexes),
		root:       root,
		indexes:    indexes,
	}
}

func (l *localFileSystem) Exists(prefix string, filepath string) bool {
	if p := strings.TrimPrefix(filepath, prefix); len(p) < len(filepath) {
		name := path.Join(l.root, p)
		stats, err := os.Stat(name)
		if err != nil {
			return false
		}
		if stats.IsDir() {
			if !l.indexes {
				index := path.Join(name, INDEX)
				_, err := os.Stat(index)
				if err != nil {
					return false
				}
			}
		}
		return true
	}
	return false
}

func ServeRoot(urlPrefix, root string) gin.HandlerFunc {
	return Serve(urlPrefix, LocalFile(root, false))
}

// Static returns a middleware handler that serves static files in the given directory.
func Serve(urlPrefix string, fs ServeFileSystem) gin.HandlerFunc {
	fileserver := http.FileServer(fs)
	if urlPrefix != "" {
		fileserver = http.StripPrefix(urlPrefix, fileserver)
	}
	return func(c *gin.Context) {
		if fs.Exists(urlPrefix, c.Request.URL.Path) {
			fileserver.ServeHTTP(c.Writer, c.Request)
			c.Abort()
		}
	}
}

type embedFileSystem struct {
	http.FileSystem
}

func (e embedFileSystem) Exists(prefix string, path string) bool {
	_, err := e.Open(path)
	if err != nil {
		return false
	}
	return true
}

func EmbedFolder(fsEmbed embed.FS, targetPath string) ServeFileSystem {
	fsys, err := fs.Sub(fsEmbed, targetPath)
	if err != nil {
		panic(err)
	}
	return embedFileSystem{
		FileSystem: http.FS(fsys),
	}
}
```

# 相关链接：

Gin + embed+vue3打包项目：https://milu.ink/382.html

推荐Github上15个学习Vue3开源项目：https://juejin.cn/post/7198412948494139448



组件库：
ArcoDesign：字节跳动团队开源的企业级产品设计系统，包含一套Vue3/React UI 组件库


# vue + go的相关项目：
gin-vue-admin：Gin + Vue
github：https://github.com/flipped-aurora/gin-vue-admin
demo：https://demo.gin-vue-admin.com/#/layout/dashboard

GoFlyAdmin：Gin + Vue + ArcoDesign
gitee：https://gitee.com/huang_li_shi_admin/GoFlyAdmin
github：https://github.com/huanglishi/GoFlyAdmin
demo开源版：https://sg.goflys.cn/webadmin

weave：
Github：https://github.com/qingwave/weave
demo：https://qingwave.github.io/weave/index

go-admin-team/go-admin：
Github：https://github.com/go-admin-team/go-admin

vue-vben-admin：
Github：https://github.com/vbenjs/vue-vben-admin
demo：https://www.vben.pro/




blockcheDev/blog-web：博客项目
github：https://github.com/blockcheDev/blog-web
地址：https://www.hitori.cn


