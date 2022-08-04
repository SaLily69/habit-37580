# README

## Usersテーブル

| Column              | Type    | Options                   |
| ------------------- | ------- | ------------------------- |
| nickname            | string  | null: false               |

### Association
- has_one :goal

## Goalsテーブル
| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| theme                | string     | null: false                    |
| purpose              | string     | null: false                    |
| target_total_time    | time       |                                |
| user_id              | references | null: false ,foreign_key: true |

### Association
- belongs_to :goal
- has_many :logs

## Logsテーブル
| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| study_day        | data       | null: false                    |
| start_time       | time       | null: false                    |
| finish_time      | time       | null: false                    |
| total_time       | time       | null: false                    |
| task             | text       |                                |
| feed_back        | integer    | null: false                    |
| time_remind      | datetime   | null: false                    |
| goal_id          | references | null: false ,foreign_key: true |

### Association
- belongs_to :goal









