# ！！各モデルにidを指定すると、新規作成時にエラーとなるので、コメントアウト！！
# ============================== ユーザー作成 ==============================
# 男性ユーザー(10名)+女性ユーザー(10名)を作成　男女交互に5名ずつ作成
User.create!(
  # id: 1,
  name:  "佐藤　蒼",
  email: "example-1@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 39,
  prefecture_code: 14,
  sex: 0,
  introduction: "仕事ばかりで出会いがなくて、初めてみました。よろしくお願いします！",
  admin: true
)

User.create!(
  # id: 2,
  name:  "鈴木　樹",
  email: "example-2@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 37,
  prefecture_code: 13,
  sex: 0,
  introduction: "お酒を飲むのが好きです。休日は飲みに行くことが多いです。よろしくお願いします！",
)

User.create!(
  # id: 3,
  name:  "高橋　蓮",
  email: "example-3@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 35,
  prefecture_code: 12,
  sex: 0,
  introduction: "仕事は不動産の営業をしています。素敵な出会いがあれば嬉しいです。",
)

User.create!(
  # id: 4,
  name:  "田中　陽翔",
  email: "example-4@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 33,
  prefecture_code: 11,
  sex: 0,
  introduction: "職場での出会いがなくて、初めてみました。気軽にお話したいです！",
)

User.create!(
  # id: 5,
  name:  "伊藤　律",
  email: "example-5@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 31,
  prefecture_code: 14,
  sex: 0,
  introduction: "こういうのは不慣れですが、よろしくお願いします。",
)

User.create!(
  # id: 6,
  name:  "吉田　陽葵",
  email: "example-6@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 30,
  prefecture_code: 11,
  sex: 1,
  introduction: "動物が大好きです！動物が好きな方と繋がりたいです！",
)

User.create!(
  # id: 7,
  name:  "山田　凛",
  email: "example-7@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 28,
  prefecture_code: 12,
  sex: 1,
  introduction: "趣味は旅行です。国内旅行によく行きます。よろしくお願いします。",
)

User.create!(
  # id: 8,
  name:  "佐々木　詩",
  email: "example-8@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 27,
  prefecture_code: 13,
  sex: 1,
  introduction: "Webデザイナーとして働いています。趣味はカフェ巡りです。",
)

User.create!(
  # id: 9,
  name:  "山口　結菜",
  email: "example-9@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 20,
  prefecture_code: 14,
  sex: 1,
  introduction: "女子大で出会いがなくて、初めてみました。年上の男性が好きです。",
)

User.create!(
  # id: 10,
  name:  "松本　結愛",
  email: "example-10@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 29,
  prefecture_code: 11,
  sex: 1,
  introduction: "最近、カメラを始めてみました。よろしくお願いします。",
)

User.create!(
  # id: 11,
  name:  "渡辺　朝陽",
  email: "example-11@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 30,
  prefecture_code: 13,
  sex: 0,
  introduction: "商社で働いています。お酒好きの方、一緒に飲みに行きましょう！",
)

User.create!(
  # id: 12,
  name:  "山本　湊",
  email: "example-12@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 28,
  prefecture_code: 12,
  sex: 0,
  introduction: "趣味で音楽活動をしています。音楽好きな人はお話しましょう！",
)

User.create!(
  # id: 13,
  name:  "中村　新",
  email: "example-13@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 25,
  prefecture_code: 11,
  sex: 0,
  introduction: "ジムのインストラクターをしています。趣味は、筋トレと自転車です。",
)

User.create!(
  # id: 14,
  name:  "小林　大和",
  email: "example-14@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 22,
  prefecture_code: 14,
  sex: 0,
  introduction: "IT業界で働いています。今年、社会人１年目です！まずは、気軽にお話しましょう！",
)

User.create!(
  # id: 15,
  name:  "加藤　大翔",
  email: "example-15@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 23,
  prefecture_code: 13,
  sex: 0,
  introduction: "食べることが趣味です。一緒に食べ歩きしたいです！",
)

User.create!(
  # id: 16,
  name:  "井上　莉子",
  email: "example-16@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 26,
  prefecture_code: 12,
  sex: 1,
  introduction: "食べることが好きです！美味しいお店を紹介して欲しいです！！",
)

User.create!(
  # id: 17,
  name:  "木村　結月",
  email: "example-17@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 27,
  prefecture_code: 13,
  sex: 1,
  introduction: "大学までバスケをしていました！最近は、バスケ観戦によく行っています！！",
)

User.create!(
  # id: 18,
  name:  "林　紬",
  email: "example-18@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 25,
  prefecture_code: 14,
  sex: 1,
  introduction: "職場での出会いがないので、始めてみました。
  緊張しやすいので、リードしてくださる方だと嬉しいです。",
)

User.create!(
  # id: 19,
  name:  "斎藤　澪",
  email: "example-19@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 22,
  prefecture_code: 11,
  sex: 1,
  introduction: "歯科衛生士をしています。趣味は海外旅行です！今年はハワイに行きたいなあ〜！！",
)

User.create!(
  # id: 20,
  name:  "清水　結衣",
  email: "example-20@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 26,
  prefecture_code: 12,
  sex: 1,
  introduction: "保育士として働いています。友達に勧められて始めてみました。よろしくお願いします。",
)

# 各ユーザーのプロフィール写真を設定
20.times do |n|
  user = User.find(n+1)
  io = File.open("app/assets/images/users/user#{n+1}.jpg")
  filename = "user#{n+1}.jpg"
  user.avatars.attach(io: io, filename: filename)
end

# ゲストユーザーを作成
User.create!(
  # id: 21,
  name:  "桜木　花道",
  email: "guest@example.com",
  password:              "foobar",
  password_confirmation: "foobar",
  age: 28,
  prefecture_code: 13,
  sex: 0,
  introduction: "初めまして！ご覧頂き、ありがとうございます！
  趣味はバスケ観戦と筋トレです。よろしくお願いします！！",
  notification: true,
)

# ゲストユーザーのプロフィール写真を設定
guest = User.find(21)
guest.avatars.attach(io: File.open("app/assets/images/guest/guest1-1.jpg"), filename: "guest1-1.jpg")
guest.avatars.attach(io: File.open("app/assets/images/guest/guest1-2.jpg"), filename: "guest1-2.jpg")

# ============================== マッチング ==============================
# ゲストユーザーが3人とマッチングする
Relationship.create!(follower_id:19, followed_id:21)
Relationship.create!(follower_id:21, followed_id:19)
Relationship.create!(follower_id:17, followed_id:21)
Relationship.create!(follower_id:21, followed_id:17)
Relationship.create!(follower_id:6, followed_id:21)
Relationship.create!(follower_id:21, followed_id:6)

# ゲストユーザーが3人からいいね！をされる
Relationship.create!(follower_id:18, followed_id:21)
Relationship.create!(follower_id:10, followed_id:21)
Relationship.create!(follower_id:7, followed_id:21)

# ゲストユーザーが3人にいいね！をする
Relationship.create!(follower_id:21, followed_id:16)
Relationship.create!(follower_id:21, followed_id:9)
Relationship.create!(follower_id:21, followed_id:8)

# user15が1人とマッチングする
Relationship.create!(follower_id:16, followed_id:15)
Relationship.create!(follower_id:15, followed_id:16)

# user14が1人とマッチングする
Relationship.create!(follower_id:19, followed_id:14)
Relationship.create!(follower_id:14, followed_id:19)

# user11が1人とマッチングする
Relationship.create!(follower_id:4, followed_id:11)
Relationship.create!(follower_id:11, followed_id:4)

# user13が2人にいいね！をする
Relationship.create!(follower_id:13, followed_id:17)
Relationship.create!(follower_id:13, followed_id:7)

# user12が2人にいいね！をする
Relationship.create!(follower_id:12, followed_id:18)
Relationship.create!(follower_id:12, followed_id:9)

# user4が2人にいいね！をする
Relationship.create!(follower_id:4, followed_id:16)
Relationship.create!(follower_id:4, followed_id:6)

# ============================== メッセージ ==============================
# ゲストユーザーとuser19とのメッセージ内容
Room.create!
Entry.create!(user_id: 21, room_id: 1)
Entry.create!(user_id: 19, room_id: 1)
Message.create!(user_id:21, room_id:1, content: "初めまして！桜木と申します。よろしくお願いします！")
Message.create!(user_id:19, room_id:1, content: "斎藤と申します。こちらこそ、よろしくお願いします！")
Message.create!(user_id:21, room_id:1, content: "海外旅行がお好きなんですね！おすすめの場所とかありますか？")
Message.create!(user_id:19, room_id:1, content: "やっぱりハワイですかね！プロフィール写真はハワイで撮ったものです！")
Message.create!(user_id:21, room_id:1, content: "そうなんですね！良かったら、ハワイでおすすめのお店教えてください！")

# ゲストユーザーとuser17とのメッセージ内容
Room.create!
Entry.create!(user_id: 21, room_id: 2)
Entry.create!(user_id: 17, room_id: 2)
Message.create!(user_id:17, room_id:2, content: "桜木さんのバスケ観戦デートが気になって、マッチングさせてもらいました！よろしくお願いします！")
Message.create!(user_id:21, room_id:2, content: "バスケ好きさんとマッチングできて、嬉しいです！是非、バスケ観戦行きませんか？")
Message.create!(user_id:17, room_id:2, content: "ぜひ、行きましょう！記載頂いている日時で大丈夫です！")
Message.create!(user_id:21, room_id:2, content: "良かったです！では後ほど、集合場所をお伝えしますね！")
Message.create!(user_id:17, room_id:2, content: "はーい、お待ちしています(^ー^)")

# ゲストユーザーとuser6とのメッセージ内容
Room.create!
Entry.create!(user_id: 21, room_id: 3)
Entry.create!(user_id: 6, room_id: 3)
Message.create!(user_id:6, room_id:3, content: "桜木さんと猫カフェに行きたいなと思って、マッチングさせてもらいました！")
Message.create!(user_id:21, room_id:3, content: "動物がお好きなんですね！是非、一緒に行きましょう！")
Message.create!(user_id:6, room_id:3, content: "ぜひお願いします！ちなみに、桜木さんはどんな猫の種類がお好きなんですか？")
Message.create!(user_id:21, room_id:3, content: "私は、スコティッシュフォールドが好きです！吉田さんはいかがですか？")
message = Message.find(14)
message.picture.attach(io: File.open("app/assets/images/message/message1.jpg"), filename: "message1.jpg")
Message.create!(user_id:6, room_id:3, content: "えー、一緒です！可愛いですよね！より、お話するのが楽しみなってきました(｡>ω<｡)")
Message.create!(user_id:21, room_id:3, content: "本当ですか！それは嬉しい！記載の日時でご都合大丈夫ですか？")
Message.create!(user_id:6, room_id:3, content: "はい、大丈夫ですよ！")
Message.create!(user_id:21, room_id:3, content: "分かりました！では、当日は吉祥寺駅北口に集合でお願いします！")

# ============================== デート作成 ==============================
# デートを作成(12件)
Datespot.create!(
  # id: 1,
  name: "浅草",
  prefecture_code: 13,
  address: "東京都台東区浅草2-3-1",
  range: 3,
  invitation: "仲見世通り商店街で食べ歩き！",
  date: Date.today + 7,
  time_zone: 2,
  tag_list: "食べ歩き,浅草",
  reference_url: "https://e-asakusa.jp/",
  plan: "きびだんごやあげまんじゅうなどの浅草名物を食べ歩きしませんか？
  その後、人力車に乗って浅草の街を回るのもありです！",
  user_id: 13,
)

Datespot.create!(
  # id: 2,
  name: "井の頭恩賜公園",
  prefecture_code: 13,
  address: "東京都武蔵野市御殿山1-18−31",
  range: 0,
  invitation: "公園をゆったりお散歩！",
  date: Date.today + 7,
  time_zone: 1,
  tag_list: "公園,散歩,吉祥寺",
  reference_url: "https://www.kensetsu.metro.tokyo.lg.jp/jimusho/seibuk/inokashira/index.html",
  plan: "緑が豊かな公園をゆったり散歩しながら、お話しませんか？
  最近カメラを始めたので、公園の景色を撮ったりもしたいです！",
  user_id: 10,
)

Datespot.create!(
  # id: 3,
  name: "叙々苑 六本木本店",
  prefecture_code: 13,
  address: "東京都港区六本木7-14-4",
  range: 5,
  invitation: "美味しい焼肉食べませんか？",
  date: Date.today + 6,
  time_zone: 3,
  tag_list: "焼肉,六本木",
  reference_url: "https://www.jojoen.co.jp/shop/jojoen/roppongi/",
  plan: "美味しいお肉を食べながら、二人でゆっくりとお話しましょう。
  お会計が全てこちらで負担するので、お気軽に来てください！",
  user_id: 1,
)

Datespot.create!(
  # id: 4,
  name: "江の島",
  prefecture_code: 14,
  address: "神奈川県藤沢市江の島1-4-13",
  range: 3,
  invitation: "江の島の観光地を巡ろう！",
  date: Date.today + 5,
  time_zone: 4,
  tag_list: "江の島,散歩",
  reference_url: "https://www.fujisawa-kanko.jp/",
  plan: "江の島の様々な観光地を巡りながら散歩ツアー！！
  まずは、「弁財天仲見世通り」をブラブラしながら、色々とお話しましょう！
  そして、「江島神社」でお参りをしたら、
  「江の島シーキャンドル」の屋外展望台から、江の島の海景色を一緒に堪能しましょう！！",
  user_id: 14,
)

Datespot.create!(
  # id: 5,
  name: "プラネタリウム満天",
  prefecture_code: 13,
  address: "東京都豊島区東池袋3-1-3",
  range: 2,
  invitation: "プラネタリウムが観たい！！",
  date: Date.today + 5,
  time_zone: 2,
  tag_list: "プラネタリウム,癒し",
  reference_url: "https://planetarium.konicaminolta.jp/manten/",
  plan: "プラネタリウムで日頃の疲れを癒しませんか？
  アロマオイルの香りと共に音楽を聞いて星空を見れるので、嫌なことが全て忘れられますよ。",
  user_id: 7,
)

Datespot.create!(
  # id: 6,
  name: "東京タワー",
  prefecture_code: 13,
  address: "東京都港区芝公園4-2-8",
  range: 3,
  invitation: "東京タワーから最高の夜景を！",
  date: Date.today + 5,
  time_zone: 3,
  tag_list: "東京タワー,夜景",
  reference_url: "https://www.tokyotower.co.jp/",
  plan: "地上250メートルのトップデッキからの夜景を二人で楽しみませんか？
  多面ガラスに囲まれたユニークな展望台から、都心を一望できます。",
  user_id: 12,
)

Datespot.create!(
  # id: 7,
  name: "横浜中華街",
  prefecture_code: 14,
  address: "神奈川県横浜市中区山下町",
  range: 3,
  invitation: "中華街で食べ歩きをしよう！",
  date: Date.today + 4,
  time_zone: 2,
  tag_list: "中華,食べ歩き,横浜",
  reference_url: "https://www.chinatown.or.jp/",
  plan: "中華街をブラブラ歩きながら、食べ歩きしませんか？
  美味しい焼き小籠包や肉まんを紹介します！",
  user_id: 15,
)

Datespot.create!(
  # id: 8,
  name: "アリーナ立川立飛",
  prefecture_code: 13,
  address: "東京都立川市泉町500-4",
  range: 2,
  invitation: "一緒にバスケ観戦しませんか？",
  date: Date.today + 4,
  time_zone: 2,
  tag_list: "バスケ,スポーツ",
  reference_url: "https://www.arenatachikawatachihi.com/",
  plan: "Bリーグの試合を１階席から観戦！大迫力の試合を間近で観れる絶好の席です！
  バスケ観戦初心者の方でも大歓迎！ルールや応援の仕方など教えます！
  その後、ららぽーと立川立飛でお買い物とお食事でもしませんか？",
  user_id: 21,
)

# デートの写真を1枚設定
8.times do |n|
  datespot = Datespot.find(n+1)
  io = File.open("app/assets/images/datespots/datespot#{n+1}.jpg")
  filename = "datespot#{n+1}.jpg"
  datespot.images.attach(io: io, filename: filename)
end

Datespot.create!(
  # id: 9,
  name: "てまりのおうち",
  prefecture_code: 13,
  address: "東京都武蔵野市吉祥寺2-13-14",
  range: 1,
  invitation: "猫カフェで癒してもらおう！",
  date: Date.today + 3,
  time_zone: 2,
  tag_list: "猫カフェ,癒し,吉祥寺",
  reference_url: "http://www.temarinoouchi.com/",
  plan: "扉を開くと、そこには異空間にトリップしたようなメルヘンな世界が広がっています！
  猫カフェでたくさんの猫と触れ合いながら、癒してもらおう！
  その後、吉祥寺の美味しいイタリアンのお店でディナーでもいかがですか？",
  user_id: 21,
)

# デートの写真を2枚設定
datespot = Datespot.find(9)
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot9-1.jpg"), filename: "datespot9-1.jpg")
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot9-2.jpg"), filename: "datespot9-2.jpg")

Datespot.create!(
  # id: 10,
  name: "新宿西口思い出横丁",
  prefecture_code: 13,
  address: "東京都新宿区西新宿1-2",
  range: 3,
  invitation: "一緒に飲み歩きしませんか？",
  date: Date.today + 2,
  time_zone: 3,
  tag_list: "お酒,飲み歩き,新宿",
  reference_url: "http://shinjuku-omoide.com/",
  plan: "70軒以上の飲食店が立ち並ぶ、昭和ノスタルジーを感じさせてくれるスポットで飲み歩き！
  お酒を飲みながら、楽しくお話しましょう！お酒をたくさん飲める人だと嬉しいです！",
  user_id: 11,
)

# デートの写真を2枚設定
datespot = Datespot.find(10)
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot10-1.jpg"), filename: "datespot10-1.jpg")
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot10-2.jpg"), filename: "datespot10-2.jpg")

Datespot.create!(
  # id: 11,
  name: "アクアパーク品川",
  prefecture_code: 13,
  address: "東京都港区高輪4-10−30",
  range: 2,
  invitation: "イルカショーを観に行こう！！",
  date: Date.today + 2,
  time_zone: 2,
  tag_list: "水族館,イルカショー,癒し",
  reference_url: "http://www.aqua-park.jp/aqua/index.html",
  plan: "光と音が織りなす圧巻のイルカショー「ドルフィンパフォーマンス」を一緒に観ませんか？
  様々な模様などを刻むウォーターカーテンや光と音の演出で、
  ミュージカルを見ているかのような感覚になります！
  しかも、イルカショーだけでなく、色とりどりの魚と出会う「リトルパラダイス」や
  海中散歩が楽しめる「ワンダーチューブ」など11のエリアがあり、見所満載です！！
  是非、ご一緒にいかがでしょうか？",
  user_id: 4,
)

# デートの写真を2枚設定
datespot = Datespot.find(11)
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot11-1.jpg"), filename: "datespot11-1.jpg")
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot11-2.jpg"), filename: "datespot11-2.jpg")

Datespot.create!(
  # id: 12,
  name: "お台場",
  prefecture_code: 13,
  address: "東京都港区台場1-4",
  range: 3,
  invitation: "お台場で最高の一日を！",
  date: Date.today + 1,
  time_zone: 4,
  tag_list: "お台場,フジテレビ,お散歩",
  reference_url: "https://www.tokyo-odaiba.net/",
  plan: "お台場の様々なスポットを回るデートツアー！！
  まずは、「お台場海浜公園」をお散歩しながら、色々とお話しましょう！
  その後、「フジテレビ本社」を見学！球体展望室から臨海副都心の大パノラマを観ましょう！
  最後は、ザ・お台場とも言える「自由の女神像」の前で記念撮影！
  東京タワーやレインボーブリッジを背にたっているので、インスタ映え間違いなし！
  ご一緒に行けるのを楽しみにしています！！",
  user_id: 21,
)

# デートの写真を2枚設定
datespot = Datespot.find(12)
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot12-1.jpg"), filename: "datespot12-1.jpg")
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot12-2.jpg"), filename: "datespot12-2.jpg")

Datespot.create!(
  # id: 13,
  name: "東京ドームシティ",
  prefecture_code: 13,
  address: "東京都文京区後楽1-3-61",
  range: 2,
  invitation: "遊園地で一緒に遊びませんか？",
  date: Date.today + 1,
  time_zone: 2,
  tag_list: "遊園地,観覧車",
  reference_url: "https://at-raku.com/",
  plan: "都心からアクセスしやすい遊園地で一緒に遊びませんか？
  最高傾斜角度80度！最高速度130km/h！
  観覧車の中心をくぐり抜けるスリルを味わえるジェットコースター「サンダードルフィン」や
  地上80mから東京を眺められる観覧車「ビック・オー」など
  絶叫好きも大満足のスリル系からほのぼの系まで約26種類のアトラクションが揃っています。
  是非、ご一緒に行けるのを楽しみにしています！！",
  user_id: 14,
)

# デートの写真を1枚設定
datespot = Datespot.find(13)
datespot.images.attach(io: File.open("app/assets/images/datespots/datespot13.jpg"), filename: "datespot13.jpg")

# ============================== 行きたい！リクエスト ==============================
# ゲストユーザーの提案が行きたい！リクエストされる
List.create!(user_id: 21, datespot_id: 12, from_user_id: 18)
List.create!(user_id: 21, datespot_id: 9, from_user_id: 6)
List.create!(user_id: 21, datespot_id: 8, from_user_id: 17)

# ゲストユーザーが行きたい！リクエストをする
List.create!(user_id: 7, datespot_id: 5, from_user_id: 21)

# それ以外の行きたい！リクエスト
List.create!(user_id: 14, datespot_id: 13, from_user_id: 7)
List.create!(user_id: 4, datespot_id: 11, from_user_id: 8)
List.create!(user_id: 11, datespot_id: 10, from_user_id: 16)

# ============================== お気に入り登録 ==============================
# ゲストユーザーの提案がお気に入り登録される
Favorite.create!(user_id: 19, datespot_id: 12)
Favorite.create!(user_id: 6, datespot_id: 9)

# ゲストユーザーがお気に入り登録をする
Favorite.create!(user_id: 21, datespot_id: 5)
Favorite.create!(user_id: 21, datespot_id: 2)

# それ以外のお気に入り登録
Favorite.create!(user_id: 7, datespot_id: 13)
Favorite.create!(user_id: 16, datespot_id: 10)

# ============================== 閲覧履歴 ==============================
# ゲストユーザーの閲覧履歴
BrowsingHistory.create!(user_id: 21, datespot_id: 5)
BrowsingHistory.create!(user_id: 21, datespot_id: 2)

# ============================== コメント ==============================
# ！提案の並び順を崩さないように、datespot_idが小さい順（昇順）にコメントを作成！
# 他の提案にコメントを作成-1
Comment.create!(user_id: 16, datespot_id: 1, rate: 5, content: "あげまんじゅう食べたい！")

# ゲストユーザーが他の提案にコメントをする-1
Comment.create!(user_id: 21, datespot_id: 2, rate: 4, content: "公園をお散歩するの気持ち良さそうですね！")

# 他の提案にコメントを作成-2
Comment.create!(user_id: 16, datespot_id: 3, rate: 5, content: "美味しい焼肉食べたい！")
Comment.create!(user_id: 7, datespot_id: 4, rate: 4, content: "海景色見たいです！")

# ゲストユーザーが他の提案にコメントをする-2
Comment.create!(user_id: 21, datespot_id: 5, rate: 5, content: "プラネタリウムいいですね！")

# 他の提案にコメントを作成-3
Comment.create!(user_id: 1, datespot_id: 5, rate: 5, content: "プラネタリウムで癒されたい・・・笑")
Comment.create!(user_id: 10, datespot_id: 6, rate: 4, content: "綺麗な夜景を写真で撮りたい！")
Comment.create!(user_id: 16, datespot_id: 7, rate: 5, content: "焼き小籠包食べたい！")

# ゲストユーザーの提案にコメントされる-1
Comment.create!(user_id: 2, datespot_id: 8, rate: 4, content: "男でもいいですか？笑")
Comment.create!(user_id: 17, datespot_id: 8, rate: 5, content: "バスケ観戦いいですね！")
Comment.create!(user_id: 18, datespot_id: 8, rate: 5, content: "ルールを教えてくれるのはいいですね！")
Comment.create!(user_id: 1, datespot_id: 9, rate: 4, content: "猫カフェで癒されたい・・・笑")
Comment.create!(user_id: 6, datespot_id: 9, rate: 5, content: "猫カフェ最高ですね！")
Comment.create!(user_id: 7, datespot_id: 9, rate: 4, content: "興味あるんですけど、初めてでも大丈夫ですか？")

# 他の提案にコメントを作成-4
Comment.create!(user_id: 16, datespot_id: 10, rate: 5, content: "美味しいものも食べたい！")
Comment.create!(user_id: 8, datespot_id: 11, rate: 5, content: "イルカショー迫力ありそう！")
Comment.create!(user_id: 1, datespot_id: 11, rate: 5, content: "水族館で癒されたい・・・笑")

# ゲストユーザーの提案にコメントされる-2
Comment.create!(user_id: 9, datespot_id: 12, rate: 4, content: "自由の女神像の前で記念撮影したい！")
Comment.create!(user_id: 10, datespot_id: 12, rate: 4, content: "臨海副都心の大パノラマを写真で撮りたい！")

# 他の提案にコメントを作成-5
Comment.create!(user_id: 7, datespot_id: 13, rate: 5, content: "観覧車に乗りたいです！")
Comment.create!(user_id: 19, datespot_id: 13, rate: 5, content: "ジェットコースター面白そう！")
Comment.create!(user_id: 2, datespot_id: 13, rate: 4, content: "男でもいいですか？笑")

# ============================== 通知 ==============================
# ゲストユーザーの通知を作成(varietyは順不同)
# variety: 1 → 行きたい！リクエストをもらう, variety: 2 → コメントをもらう, variety: 3 → いいね！をもらう, variety: 4 → メッセージをもらう
Notification.create!(user_id: 21, variety: 2, from_user_id: 2, datespot_id: 8, content: "男でもいいですか？笑")
Notification.create!(user_id: 21, variety: 1, from_user_id: 18, datespot_id: 12)
Notification.create!(user_id: 21, variety: 2, from_user_id: 1, datespot_id: 9, content: "猫カフェで癒されたい・・・笑")
Notification.create!(user_id: 21, variety: 3, from_user_id: 19)
Notification.create!(user_id: 21, variety: 1, from_user_id: 6, datespot_id: 9)
Notification.create!(user_id: 21, variety: 3, from_user_id: 6)
Notification.create!(user_id: 21, variety: 2, from_user_id: 6, datespot_id: 9, content: "猫カフェ最高ですね！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 19, content: "斎藤と申します。こちらこそ、よろしくお願いします！")
Notification.create!(user_id: 21, variety: 1, from_user_id: 17, datespot_id: 8)
Notification.create!(user_id: 21, variety: 3, from_user_id: 17)
Notification.create!(user_id: 21, variety: 4, from_user_id: 6, content: "桜木さんと猫カフェに行きたいなと思って、マッチングさせてもらいました！")
Notification.create!(user_id: 21, variety: 2, from_user_id: 18, datespot_id: 8, content: "ルールを教えてくれるのはいいですね！")
Notification.create!(user_id: 21, variety: 2, from_user_id: 7, datespot_id: 9, content: "興味あるんですけど、初めてでも大丈夫ですか？")
Notification.create!(user_id: 21, variety: 2, from_user_id: 17, datespot_id: 8, content: "バスケ観戦いいですね！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 17, content: "桜木さんのバスケ観戦デートが気になって、マッチングさせてもらいました！よろしくお願いします！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 6, content: "ぜひお願いします！ちなみに、桜木さんはどんな猫の種類がお好きなんですか？")
Notification.create!(user_id: 21, variety: 3, from_user_id: 18)
Notification.create!(user_id: 21, variety: 2, from_user_id: 9, datespot_id: 12, content: "自由の女神像の前で記念撮影したい！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 19, content: "やっぱりハワイですかね！プロフィール写真はハワイで撮ったものです！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 17, content: "ぜひ、行きましょう！記載頂いている日時で大丈夫です！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 17, content: "はーい、お待ちしています(^ー^)")
Notification.create!(user_id: 21, variety: 2, from_user_id: 10, datespot_id: 12, content: "臨海副都心の大パノラマを写真で撮りたい！")
Notification.create!(user_id: 21, variety: 4, from_user_id: 6, content: "えー、一緒です！可愛いですよね！より、お話するのが楽しみなってきました(｡>ω<｡)")
Notification.create!(user_id: 21, variety: 4, from_user_id: 6, content: "はい、大丈夫ですよ！")
Notification.create!(user_id: 21, variety: 3, from_user_id: 10)
Notification.create!(user_id: 21, variety: 3, from_user_id: 7)
