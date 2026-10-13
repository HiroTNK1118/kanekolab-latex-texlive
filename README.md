# kanekolab-latex-texlive

TeX LiveをDocker上で動かすためのコンテナビルド用リポジトリ

|  Ver.  |    date    |                                                      base image                                                       | texlive |    Arch.     | repository                                                                                                  |
| :----: | :--------: | :-------------------------------------------------------------------------------------------------------------------: | :-----: | :----------: | ----------------------------------------------------------------------------------------------------------- |
| 0.1.0  | 2024/9/30  |                                                     ubuntu:22.04                                                      |  2024   |    amd64     | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/281401957?tag=0.1.0)        |
| 0.2.0  | 2024/10/7  |                                                     ubuntu:22.04                                                      |  2024   |    amd64     | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/285022331?tag=0.2.0)        |
| 0.3.0  | 2024/10/8  |                                                     ubuntu:22.04                                                      |  2024   |    amd64     | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/285022331?tag=0.2.0)        |
| 0.4.0  | 2024/10/8  |                                                     ubuntu:22.04                                                      |  2024   | amd64, arm64 | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/285739845?tag=0.4.0)        |
| 0.5.0  | 2024/11/10 |                                                     ubuntu:22.04                                                      |  2024   | amd64, arm64 | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/303239648?tag=0.5.0)        |
| 24.0.0 | 2024/12/13 |     [hirotnk1118/docker-test-base:24.04.0](https://github.com/HiroTNK1118/docker-test-base/releases/tag/24.04.0)      |  2024   |    amd64     | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/322115012?tag=24.0.0-amd64) |
| 24.1.0 | 2024/12/18 |      [hirotnk1118/docker-test-base:24.0.0](https://github.com/HiroTNK1118/docker-test-base/releases/tag/24.0.0)       |  2024   | amd64, arm64 | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/324576771?tag=24.1.0)       |
| 24.2.0 | 2025/1/13  |      [hirotnk1118/docker-test-base:24.1.0](https://github.com/HiroTNK1118/docker-test-base/releases/tag/24.1.0)       |  2024   | amd64, arm64 | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/336101401?tag=24.2.0)       |
| 24.3.0 | 2025/1/30  |      [hirotnk1118/docker-test-base:24.2.0](https://github.com/HiroTNK1118/docker-test-base/releases/tag/24.2.0)       |  2024   | amd64, arm64 | [ghcr.io](https://github.com/HiroTNK1118/docker-test/pkgs/container/docker-test/346136001?tag=24.3.0)       |
| 26.0.0 | 2026/10/13 | [hirotnk1118/kanekolab-latex-texlive:26.2.0](https://github.com/HiroTNK1118/kanekolab-latex-base/releases/tag/26.2.0) |  2026   |    amd64     | [ghcr.io]()                                                                                                 |

※24.0.0以降よりバージョン命名法を「<texliveのバージョン>.<イメージのバージョン>.<リビジョン番号>」に変更しました

## 概要

- LaTeX実行環境のためのDockerイメージです
- ubuntu (~v24.x)、Debian(v26.x~)上にTeX Liveをインストールしています
- ~~マルチアーキテクチャ対応しています~~
- マルチアーキテクチャ対応はTeX Live公式イメージでの実装に変更する開発方針となりました
  - amd64 (intel系, AMD系)
  - ~~arm64 (Apple Silicon, Snapdragon X)~~

## 使い方

[卒修論執筆テンプレートのリポジトリ](https://github.com/HiroTNK1118/latex-template-kanekolab)を参照ください

## 収録される主なLaTeXパッケージ (v26.0.0)

※`collection-__`に含まれるパッケージは[こちら](https://gist.github.com/nox40/6255eef548ccad9881ce7202e3bb75dd#file-collection-depends-md)を参照ください

- `collection-bibtexextra`
- `collection-latexextra`
- `collection-latexrecommended`
- `collection-luatex`
- `collection-langjapanese`
- `collection-mathscience`
- `collection-pictures`
- `latexmk`
- `latexdiff`
- `stix2-otf`
- `latexindent`
