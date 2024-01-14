# docker-exec-for-nginx-python-postgresql
DockerでNginx, Python, PostgreSQLの実行環境を構築する。

<br>

# PostgreSQLのversion設定
[.env](.env)のPOSTGRESQL_VERSIONの値を指定することにより`初回docker-compose up時`に指定したversionのPostgreSQLがinstallされる。

```
POSTGRESQL_VERSION = ${任意のversion}
```

> [!WARNING]
> PostgreSQLのversionはよく考慮してから`初回docker-compose up`を推奨する。<br>
> `/etc`と`/var`のpath配下を[永続化](https://qiita.com/snooow/items/04a84193fb6c7076e86f)している。<br>
> この為、DB内容や設定はが失われることはない。<br>
> 一方で、DBバージョンを後から変更したい場合。データ待避などの考慮が必要。<br>
>
> 未だ手順化出来ていない為、後からDBバージョン変更をしたい場合は、[NaoyaOgura](https://github.com/NaoyaOgura0828)へ問い合わせてください。<br>

<br>

# ローカル環境からフロントサイトへのアクセス。
ローカル環境のブラウザで下記へアクセスする。

```
http://localhost:50080/
```

> [!TIP]
> [.env](.env)のLOCALHOST_PORTの値を変更することにより、任意のportを設定することが可能。<br>
>
> ```
> http://localhost:${任意のport}/
> ```

<br>

# postgres デフォルトユーザーへの切替
コンテナ環境のbashで以下を実行する。

```bash
sudo -i -u postgres
```

<br>

# Postgresql Clientの実行
[postgres デフォルトユーザーへの切替](#postgres-デフォルトユーザーへの切替)を実行した後に下記をコンテナ環境のbashで実行する。

```bash
psql
```

> [!TIP]
> デフォルトユーザー以外は作成されていない。<br>
> 必要に応じて作成する必要がある。
