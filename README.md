## アプリケーション名　
shopping_calendar

## アプリケーション概要
販売店毎のイベント（ポイント増加等）をメモとして投稿し、投稿した側は投稿内容がカレンダーへ表示される。投稿を見る側は、お気に入りに入れることで自身のカレンダーへ表示できる。

## URL
URL：https://shopping-calendar.onrender.com


## テスト用アカウント
ユーザー名: サンプル
Email : test@test
Password : qwe123456

## 利用方法
### ユーザー登録
1 ユーザー登録は必須 \
2 登録時に、nickname, email, password, region_id, cityの入力 \
3 記入後登録ボタンを押し、新規登録完了

### ログイン後の表示
1 トップページはマイページを表示し、１か月ごとのカレンダー表示 \
2 カレンダーには、自身の投稿したメモの内容、お気に入りに登録したメモの内容が対象日に記載されている\
3 トップページからメモ投稿機能へ遷移するボタン\
4 トップページから自身の投稿、お気に入り追加の詳細へ遷移するボタン

### メモ投稿機能
1 title, day, contentを記入し投稿することでカレンダーの表示に追加\
2 追加された投稿は、一覧画面にも送られ追加される\
3一覧画面から、お気に入りに登録することで投稿していないユーザーでもカレンダーに追加\

## アプリケーションを開発した背景
物価高などの影響で、以前の感覚で買い物に行くと全ての物が高く感じてしまう。\
そんな中で、各販売店などで行われているイベント（ポイント増加等）を把握しお得にお買い物をする\
ポイ活という言葉が生まれています。\
このポイ活に焦点をあて、イベント日などを確認する時間がない人にとっては情報共有の場として、\
普段から把握できている人たちからすればメモ機能として使えるアプリを開発していこうと考えました。

## 洗い出し要件
[要件定義シート](https://docs.google.com/spreadsheets/d/1rwYl3oZSqW8KgOo5AwV2ZcWYmFLtNNEOYSHcks--fRw/edit?gid=982722306#gid=982722306)
## データベース設計
[![Image from Gyazo](https://i.gyazo.com/9e05a4a419fec6b7cac2a478c786427f.png)](https://gyazo.com/9e05a4a419fec6b7cac2a478c786427f)
## 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/88bba7baf335ce8daf9068e71e20c1ad.png)](https://gyazo.com/88bba7baf335ce8daf9068e71e20c1ad)
</br>
</br>
</br>
</br>
</br>
</br>
</br>
</br>

# テーブル設計

## users テーブル
| Column              | Type     | Options                    |
| --------------------|----------|---------------------------|
| nickname            | string   | null: false               |
| email               | string   | null: false, unique: true |
| encrypted_password  | string   | null: false               |
| region_id           | integer  | null: false               |
| city                | string   | null: false               |

### Association

- has_many :events
- has_many :favorites
- belongs_to_active_hash :region

## eventsテーブル
|column           | Type          |Options                          |
|-----------------|---------------|---------------------------------|
| user            | references    | null: false   foreign_key: true |
| title           | string        | null: false                     |
| content         | text          | null: false                     |
| start_time      | date          | null: false                     |
| end_time        | date          | null: false                     |

### Association

- belongs_to :user
- has_one :favorite


## ordersテーブル
|column       | Type        |Options                            |
|-------------|-------------|--------------------------------   |
| user        | references  | null: false  foreign_key: true    |
| item        | references  | null: false  foreign_key: true    |

### Association

- belongs_to :user
- belongs_to :event

