---
title: hugo+stack搭建个人博客
description: 使用hugo+stack搭建个人博客
date: 2025-06-08
slug: hugo_stack
# image: image.jpg
categories:
    - stack
    - hugo
draft: false # 草稿
---

## 安装hugo

二进制安装：[https://github.com/gohugoio/hugo/releases](https://github.com/gohugoio/hugo/releases) 下载完成后解压hugo.exe并添加到环境变量中

其他安装方式：

```shell
# go install (1.23.0 or later) 安装
set CGO_ENABLED=1
go install -tags extended github.com/gohugoio/hugo@latest
```

查看安装情况：

```shell
# hugo version
hugo v0.147.7-189453612e4bedc4f27495a7b1145321c8d89807+extended windows/amd64 BuildDate=2025-05-31T12:41:12Z VendorInfo=gohugoio
```

## 快速开始

hugo官方文档：https://hugo.opendocs.io/getting-started/quick-start/

```shell
hugo new site MyBlog
cd MyBlog
git init
git submodule add https://github.com/CaiJimmy/hugo-theme-stack/ themes/hugo-theme-stack
echo "theme = 'hugo-theme-stack'" >> hugo.toml
hugo server
```

本地访问：http://localhost:1313

## 配置stack主题

复制模板配置文件：`MyBlog\themes\hugo-theme-stack\exampleSite\hugo.yaml` 到 `MyBlog\hugo.yaml`
复制模板内容文件夹： `MyBlog\themes\hugo-theme-stack\exampleSite\content` 到 `MyBlog\content`
复制文件夹 `MyBlog\themes\hugo-theme-stack\archetypes` 到 `MyBlog\archetypes`
复制文件`MyBlog\themes\hugo-theme-stack\.gitignore` 到 `MyBlog\.gitignore` 排除不必要的文件上传(hugo server会自动生成)
运行时有如下报错(原因可能为国内网络问题，删除部分内容重新执行hugo server)：

```
WARN  The "twitter", "tweet", and "twitter_simple" shortcodes were deprecated in v0.142.0 and will be removed in a future release. Please use the "x" shortcode instead.
ERROR template: _shortcodes/twitter_simple.html:17:25: executing "render-simple-tweet" at <resources.GetRemote>: error calling GetRemote: Get "https://publish.twitter.com/oembed?dnt=false&omit_script=true&url=https%3A%2F%2Ftwitter.com%2FDesignReviewed%2Fstatus%2F1085870671291310081": dial tcp 69.171.247.71:443: connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.
ERROR template: _shortcodes/vimeo_simple.html:26:25: executing "render-vimeo" at <resources.GetRemote>: error calling GetRemote: Get "https://vimeo.com/api/oembed.json?dnt=0&url=https%3A%2F%2Fvimeo.com%2F48912912": dial tcp 31.13.94.37:443: connectex: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond.
WARN  The "gist" shortcode was deprecated in v0.143.0 and will be removed in a future release. See https://gohugo.io/shortcodes/gist for instructions to create a replacement.
WARN  Search page not found. Create a page with layout: search.
WARN  Archives page not found. Create a page with layout: archives.
Built in 43729 ms
Error: error building site: logged 2 error(s)
```

删除 `MyBlog\content\post\rich-content\index.md`中的几个短代码

```
## Twitter Simple Shortcode

{{ < twitter_simple user="DesignReviewed" id="1085870671291310081" > }}

<br>

......

## Vimeo Simple Shortcode

{{ < vimeo_simple 48912912 > }}

......

## Gist Shortcode

{{ < gist spf13 7896402 > }}
```

修改`MyBlog\hugo.yaml`

```
title: 魔力の博客
DefaultContentLanguage: zh-cn
languages:
    zh-cn:
        languageName: 中文
        title: 魔力の博客
        weight: 2
        params:
            sidebar:
                subtitle: 斯人若彩虹，遇上方知有。
......

params:

    ......

    sidebar:
        emoji: 🍥
        subtitle: 斯人若彩虹，遇上方知有。
        avatar:
            enabled: true
            local: true
            src: avatar.png  # 这个是头像的地址

# 设置自定义的icon(侧边栏GitHub与Twitter的小图标)
        - identifier: mail
          name: mail
          url: "mailto:2621609520@qq.com"
          params:
              icon: mail # SVG 图标：主题自带的 SVG 图标来自 Tabler Icons（https://tablericons.com/） docs：https://stack-docs.netlify.app/zh/configuration/custom-menu 放在：assets/icons目录下

# paginate: 10   # 分页，10篇文章一页，旧的hugo版本使用此字段
pagination:
  pagerSize: 10  # 新版本hugo使用此字段
```

创建png格式的个人头像`avatar.png`复制到`MyBlog\assets`目录下

到此配置基本完成，可以根据自己的需要进行调整，比如删除样例中的文档

## 使用GitHub Actions自动部署

### 创建仓库并提交内容

```
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/chengcong1/chengcong1.github.io.git
git push -u origin main
```

### 设置GitHub Pages

点击github仓库About右侧设置：勾选 Use your GitHub Pages website

### 创建GitHub Token

在此页面 https://github.com/settings/tokens 创建Token，点击Generate new token (classic)
设置名称Note、设置有效期Expiration、设置权限:勾选repo、点击Generate token(只显示一次，需记录清楚)

### 设置Token

在仓库界面点击Setting-->Secrets and variables-->New repository secrets-->Name: ACCESS_TOKEN Value: 上一步生成的Token

### 创建workflows

在本地创建`.github/workflows/deploy.yaml` 内容参考：[github](https://github.com/chengcong1/chengcong1.github.io/blob/main/.github/workflows/deploy.yaml)
提交完成后自动生成public目录提交到`gh-pages`分支

### 设置GitHub Pages分支

点击仓库Settings-->Pages-->Branch-->gh-pages-->Save

### 查看静态网站

等待片刻查看是否成功：https://chengcong1.github.io/

### 其他部署方式

以上是在GitHub Actions中使用同一个仓库不同的分支实现的，也可以不同的仓库创建，或者一个私有仓库一个公开仓库。
其他非GitHub Actions部署方式：https://gohugo.io/host-and-deploy/

## 编写markdown文档
### 了解基本使用知识
slug: 是网页链接，是唯一的标识符，生成文章的访问地址比如：slug:test-chinese 时文章地址为：http://localhost:1313/p/test-chinese/
当 slug:"" 时，使用文件名作为路径

draft: true 表示草稿默认为false `hugo server --buildDrafts` 可查看草稿内容

categories: 表示分类

tags: 表示标签

多语言：页面新建index.md 默认是中文则是中文，英文则英文，另新建index.zh-cn.md或index.en.md 则表示中文或英文，同时存在index.zh-cn.md或index.en.md多个语言时，文章会显示翻译到另一个语言。

文件名：不是必须index.md 或者 index.en.md，hugo+stack搭建个人博客.md 以及 hugo+stack搭建个人博客.en.md也可以
### 文章间跳转
Hugo中如何在markdown中增加文章的内链：https://macgeeker.com/hugo/hugo-rel/

自定义的shortcode：
```
# 在layouts/shortcodes目录里新建一个文件 xrelref.html
{{ with .Site.GetPage (.Get 0) }}<a class="link" href="{{ .RelPermalink }}" title="{{ .Title }}" target="_blank">{{ .Title }}</a>{{ end }}
# 在markdown中引用，注意"{{"与"<"之间使用时没有空格
{{ < xrelref "01-append-icon.md"  > }}
```

```markdown
[Chinese Test]({{< ref "\post\temp\chinese-test\ChineseTest.md" >}})

<a class="link" target="_blank" href={{< ref "\post\temp\chinese-test\ChineseTest.md" >}} >ChineseTest</a>

<!-- 以上方式本地能运行github action发生错误。 -->
```

[Chinese Test1](/p/test-chinese/)


{{< xrelref "Chinese Test.md"  >}}

## 其他警告或错误

### page not found

```
WARN  Search page not found. Create a page with layout: search.
WARN  Archives page not found. Create a page with layout: archives.
```

创建多语言的Search与Archives
创建 `MyBlog\content\page\Search`下的`index.en.md`
创建 `MyBlog\content\page\Archives`下的`index.en.md`

### GitHub Actions运行错误

#### Error: Action failed with "The process '/usr/bin/git' failed with exit code 128"

没有权限，需要设置有权限的TOKEN

#### Error: You have to provide a GITHUB_TOKEN or GH_PAT

需要一个TOKEN

## 参考文档

hugo：https://gohugo.io/documentation/

GitHub Action: The process ‘/usr/bin/git‘ failed with exit code 128 解决方案：https://blog.csdn.net/nxg0916/article/details/129063959

【教程】Hugo+Github博客部署：https://sazerac-kk.github.io/p/%E6%95%99%E7%A8%8Bhugo-github%E5%8D%9A%E5%AE%A2%E9%83%A8%E7%BD%B2/

Hugo GitHub Actio：https://github.com/marketplace/actions/hugo-github-action

