---
title: "自前のGitHub Pagesに、Hugoを使ってBlog機能を追加する"
date: 2020-06-12T19:34:10+09:00
tags: ["githubpages", "hugo", "homepage"]
draft: false
---

# Blogページの作成
今回、すでに自前のHTMLファイルで作成していたGitHub PagesにBlog機能を追加しようと思い、巷で流行り？のHugoを用いてBlogページを追加しました。

すでに、色んな方がGitHub Pages + Hugoでサイト作成やブログ作成する方法を挙げられているので、今回はそれを見ながら行いました。

いくつかのやり方を参考にしながらトライしてみて上手くいかない方法もありましたが、結果的にこちらの[MEMBERS EDGEさんのサイト](https://www.membersedge.co.jp/blog/create-hugo-theme-and-deploy-to-github-pages/)のやり方でうまくいきました。

基本的には説明されている通りに設定すればいいだけなので難しくはないですが、GitHub PagesへのDeployはdocsディレクトリを使用するのがオススメです。

すべての設定が終わりましたら、実際にGitHub Pagesへアクセスして反映されているか確認します。

以降、新しい記事を投稿する際には、次のコマンドで新しいMarkdownファイルを生成します。

```sh
hugo new article/newpost.md
```

また、GitHub PagesへのDeployを簡略化するために、以下のようなdeploy.shを作成しておくとラクに反映できます。



```sh
# 公開ファイルの生成
hugo

# リポジトリへのpush
git add -A
msg="Update: `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"
git push
```


# Themeについて
ちなみに、私が今回用いたThemeは[notepadium](https://themes.gohugo.io/hugo-notepadium/)というものです。

Hugoには数多くのデザインが用意されており、どれを選ぶか迷ってしまうかと思います。

しかしながら、私のように独自ドメインでなくて、`"Username"/blog`のようなパスで使用する場合には一つ注意すべき点がありまして、それはSCSSに対応しているThemeしか使用できないということです。

これ以外のThemeでトライしてみると、CSSが反映されないことがわかります。

いくつか他に気に入ったデザインもあったのですが、泣く泣く諦めることにしました。

いい加減、独自ドメインにしないといけないですね...(実はもうドメインは持っている)


# 今後について
これからはこのプラットフォームで自分のコーディングのアウトプット（それ以外も？）をしていく予定です。

とりあえず、Markdown形式に慣れないといけないですが...
色々勉強ということで、手始めにMarkdown形式用のエディタとして、[Boost Note](https://boostnote.io/)をダウンロードして進めていきたいと思います。
