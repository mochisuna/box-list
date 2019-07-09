# box-list
[この記事](https://qiita.com/mochisuna/items/e6cea16025504eddb35d)の実運用を考慮したバージョン。

# 構成
環境変数を、
1. HOSTマシンから取得
1. ファイルから取得

の2つのパターンで対応。

`staging = prd` のケースにあるように、 `env/<stage>/env.yml` を利用する場合はそちらの環境変数が優先されるので注意。

# Usage
1. stageごとに `input/<stage>/box_private_key` を作成
  - このファイル自体は[プライベートキーの切り出し](https://qiita.com/mochisuna/items/e6cea16025504eddb35d#%E3%83%97%E3%83%A9%E3%82%A4%E3%83%99%E3%83%BC%E3%83%88%E3%82%AD%E3%83%BC%E3%81%AE%E5%88%87%E3%82%8A%E5%87%BA%E3%81%97)の手順を参照
1. stageごとに `env/<stage>/env.yml` を追加
  - 環境変数を利用する場合は
```
BOX_USER_ID
BOX_JWT_PRIVATE_KEY_PASSWORD
BOX_JWT_PUBLIC_KEY_ID
BOX_CLIENT_ID
BOX_CLIENT_SECRET
```
をあらかじめexportしておく
  - この場合ファイルから該当する環境変数を除外しておく（`env/dev/env.yml` の手法）

## Run
実行時は以下のようにコマンドを実行
```
sls invoke local -f box --stage <stage>
```

本番の場合は
```
sls invoke local -f box --stage prd
```

## Deoloy
以下のようにしてデプロイ
```
sls deploy --aws-profile <profile_name> --stage <stage>
```
