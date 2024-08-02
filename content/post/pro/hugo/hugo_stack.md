---
title: "自动化部署 Github Pages Action for Hugo"
subtitle: ""
date: 2024-08-02T18:08:13+08:00 # 创建日期：文章的初始创建时间
lastmod: 2024-08-02T18:08:13+08:00 # 最后修改日期：文章的最后修改时间
draft: false
image: /images/github-action.png
author: ""
authorLink: ""
description: "github Action"

tags: [工具]
categories: [hugo]
featuredImage: "/images/github-action.png"
featuredImagePreview: "/images/github-action.png"

---


## Hugo workflow 创建



### 创建deploy.yml
 在项目目录创建./github/workflow/deploy.yml
```
name: GitHub Page Deploy # 定义 GitHub Actions 工作流的名称

on: # 触发工作流的事件
  push: # 当推送代码到指定分支时触发
    branches:
      - page # 触发工作流的分支名称

jobs: # 定义工作流中的作业
  deploy: # 作业名称
    runs-on: ubuntu-latest # 指定运行作业的环境，这里使用最新的 Ubuntu

    steps: # 作业中的步骤
      - name: Checkout # 步骤名称：检出代码
        uses: actions/checkout@v2 # 使用官方的 checkout 动作
        # with:
        #   submodules: true  # 如果需要检出子模块，可以取消注释
        #   fetch-depth: 0    # 如果需要获取完整的 Git 历史，可以取消注释
      
      - name: Setup Hugo # 步骤名称：设置 Hugo
        uses: peaceiris/actions-hugo@v2 # 使用 peaceiris 提供的 Hugo 动作
        with:
          hugo-version: 'latest' # 安装最新版本的 Hugo
          extended: true # 安装扩展版的 Hugo

      - name: Build # 步骤名称：构建 Hugo 站点
        run:  
          hugo --minify --gc # 使用 Hugo 构建站点，并进行最小化和垃圾回收
          # hugo --minify -E # 如果需要，可以使用其他 Hugo 构建命令
          # hugo server -e # 如果需要，可以使用其他 Hugo 构建命令
          # hugo -D # 如果需要，可以使用其他 Hugo 构建命令
          # hugo server -e production # 如果需要，可以使用其他 Hugo 构建命令

      - name: Deploy Hugo to page # 步骤名称：部署 Hugo 站点到 GitHub Pages
        uses: peaceiris/actions-gh-pages@v3 # 使用 peaceiris 提供的 GitHub Pages 部署动作
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }} # 使用 GitHub 提供的令牌进行身份验证
          PERSONAL_TOKEN: ${{ secrets.PERSONAL_TOKEN }} # 使用个人令牌进行身份验证（如果需要）
          PUBLISH_BRANCH: gh-pages # 部署到 gh-pages 分支
          PUBLISH_DIR: ./public # 指定要部署的目录
```

<span style="color: red;">备注：</span>

GITHUB_TOKEN：参数是github action 的工作流中需要使用的，不需要做任何配置

PERSONAL_TOKEN：创建私钥，构建时用于检验工作流的权限。可移步到[私钥创建流程](https://zhuanlan.zhihu.com/p/654088195)查看

PUBLISH_BRANCH：构建后的产物部署的分支[也可以指定新的项目，当前操作时同仓库下创建的不同分支]

### 仓库设置中增加 Environments
  看了很多教程、都没有提到这一步。构建成功，但是没有任何操作。如果出现这种情况可以试试
  ![Image](images/image-action-en.png)
  ![Image](images/image-action-per.png)



### hugo 借鉴资料

[Hugo 自动构建1](https://blog.taoluyuan.com/blog/github-workflows)

[Hugo 自动构建2](https://zhuanlan.zhihu.com/p/654088195)
<!--more-->
