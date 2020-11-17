# README

## 開発にあたってのメモ
### テーブル設計

- Task テーブル
  - タスク名 name:string
  - 期限 deadline:datetime
  - 優先度 priority:string
  - 詳細 details:text
  - user_id:integer
  - status:string

- User テーブル
  - name:string
  - email:string
  - password_digest:string

- Label テーブル
  - name:string?
