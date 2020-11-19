# README

## 開発にあたってのメモ
### テーブル設計

- Task テーブル
  - タスク名 name:string    step1で実装
  - 期限 deadline:datetime  step3で追加
  - 優先度 priority:string
  - 詳細 detail:text        step1で実装
  - user_id:integer
  - status:string           step3で追加

- User テーブル
  - name:string
  - email:string
  - password_digest:string

- Label テーブル
  - name:string?

##Herokuへのアップロード
 - masterブランチへ移行
 - heroku login --interactive
 - rails assets:precompile RAILS_ENV=production
 - heroku created
 - heroku buildpacks:set heroku/ruby
 - heroku buildpacks:add --index 1 heroku/nodejs
 - git push heroku master
 - heroku run rails db:migrate

##Herokuとgithubの連携
 - https://j-hack.gitbooks.io/deploy-meteor-app-to-heroku/content/step4.html
 - git remote add origin git@github.com:~~
 - Herokuのダッシュボードにアクセス
 - GitHubと連携するアプリを選択
 - Deploy タブ→Deployment method →GitHubを選択。
 - Connect to GitHub → Connect to GitHub
 - リポジトリを検索選択してConnect
 - Automatic deploys でブランチを選択
 - ソースコードを変更してGitHubにPush
