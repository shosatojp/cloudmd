# 使い方
## コンパイル方式
コンパイル方式には「Markdown」と「Tex」の２種類があります。
<!-- 「Markdown」はpandoc、pandoc-crossref-filter、cloudmd-filter、platex、platex、platex、dvipdfmxの順にコンパイルされます。 -->
「Markdown」は`.md`ファイルを使用してコンパイルします。複数の`.md`ファイルをアップロードした場合は最後にアップロードされたもののみが使用されます。

「Tex」は`.tex`ファイルを使用してコンパイルします。複数の`.tex`ファイルをアップロードした場合は最後にアップロードされたもののみが使用されます。

## テンプレート
デフォルトで用意しているテンプレートは選択するだけで使えますが、独自のPandocテンプレートを使用することもできます。`template.tex`ファイルをアップロードするとそちらが優先して使用されます。

## パッケージ
`.sty`ファイルをアップロードし、`header-includes`に`\usepackage{}`を追記すると、任意のパッケージを使用することができます。


# 書き方

```markdown
---
title: string
subtitle: string
<!-- タイトルとサブタイトルは改行されます -->
author: string
header-includes: 
    - \usepackage{}
    - \usepackage{}
<!-- documentclassの後、begin documentの前に挿入されます -->
<!-- 追加のパッケージを使用する場合は個々に追記する必要があります -->
<!-- エラーが出る場合は.styファイルもアップロードしてください -->
---


<!-- 表 -->
:タイトル{#tbl:hoge}

|日本語| $x+y+z$ ||
|---|:---|:---:|
|デフォルト|左寄せ|中央寄せ|


<!-- 図 -->
![キャプション](./hoge.png)
![キャプション](./hoge.png){#fig:hoge}
![キャプション](./hoge.png){#fig:hoge width=100%}
![キャプション](./hoge.png){#fig:hoge width=100% height=10cm}


<!-- 見出し -->
# 大見出し
## 中見出し
### 小見出し
# ナンバリングなし {-}


<!-- 数式 -->
$$
    x + y + z
$$
<!-- eqnarray環境と同値です -->


<!-- 文章 -->
*斜体* **太文字** ***太斜体*** $インライン数式$ $\mathrm{単位}$


<!-- 相互参照 -->
[@fig:hoge]
<!-- これは「表1」に展開されます -->


<!-- 段落 -->
<!-- 空白行で段落が変わります -->
最初の段落

次の段落


<!-- 改行 -->
行末の「\」または半角スペース２つです



```


MarkdownからTexへの変換の一部にはPandocを使用しているため、[こちらのWebページ](https://pandoc.org/MANUAL.html)に記載されている記法はほとんど使用できます。