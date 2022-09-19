## アプリケーション名

habit-37580

## アプリケーション概要

自分で学習テーマ・目標・スケジュールを設定し、記録をつけられる学習進捗管理アプリ。

## URL

https://habit-37580.herokuapp.com/

## テスト用アカウント

・Basic認証ID：sayuri

・Basic認証パスワード：1210

・メールアドレス：test@test

・パスワード：test919


## 利用方法

### 学習テーマと目標を宣言する

1.新規ユーザー登録をする。

2.学習テーマと達成したい学習時間の目標を入力する。

### 学習の進捗を管理する

1.トップページにある「学習を始める」のボタンから、学習の記録を入力することができる。

2.学習の記録と一緒に、次回の学習予定を入力できる。

3.学習の記録をつけると、合計学習時間が表示される。

## アプリケーションを作成した背景

学習塾の運営のなかで、生徒さんや保護者様から一番多く聞く悩みが「家庭学習の継続が大変である」というものです。当塾における既存の学習記録アプリケーションは保護者が主体とならないと利用できないもので、使っているというお話をなかなか伺えませんでした。

自分で設定した目標に対して学習の進捗が目に見えてわかること、達成感が味わいやすいことを要件として満たすことができれば、10代のユーザーであっても主体的な学習の継続ができるのではないかと考え、アプリケーションの開発をすることにしました。

## 洗い出した要件

https://docs.google.com/spreadsheets/d/1JmMHp4AKZS0pABaFhIKfzqvzVe4ynDSpw9zkMYNNBE0/edit?usp=sharing

## 実装予定の機能

目標時間に対する進捗割合や、目標の達成回数なども記録として残せる機能を追加実装したい。

## データベース設計

### Usersテーブル

| Column              | Type    | Options                   |
| ------------------- | ------- | ------------------------- |
| nickname            | string  | null: false               |
| email               | string  | null: false               |
| encrypted_password  | string  | null: false               |

#### Association
- has_one :goal

### Goalsテーブル
| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| theme                | string     | null: false                    |
| purpose              | string     | null: false                    |
| target_total_time    | integer    | null: false                    |
| user_id              | references | null: false ,foreign_key: true |

#### Association
- belongs_to :user
- has_many :logs

### Logsテーブル
| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| study_day        | data       | null: false                    |
| study_hour       | integer    | null: false                    |
| study_minute     | integer    | null: false                    |
| task             | text       |                                |
| feed_back        | integer    | null: false                    |
| time_remind      | datetime   | null: false                    |
| goal             | references | null: false ,foreign_key: true |

#### Association
- belongs_to :goal

## 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/d17a42ac7f5dc15829abdcce3989168e.png)](https://gyazo.com/d17a42ac7f5dc15829abdcce3989168e)


