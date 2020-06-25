User.create!(name:  "筋肉太郎",
             email: "example-1@muscle.com",
             password:              "password",
             password_confirmation: "password",
             bio: "筋肉は裏切らない！",
             url: "https://www.google.com",
             tel: "080-xx1-4649",
             image_name: File.open("./public/images/muscler.jpg"))

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+2}@muscle.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               bio: "筋肉は裏切らない！
               #{n}才です",
               url: "https://www.google.com",
               tel: "080-xx#{n+2}-4649")

end

users = User.order(:created_at).take(50)
10.times do
  content =
  "ベンチプレス3セット
  ダンベルカール3セット
  レッグレイズ5セット"
  users.each { |user| user.microposts.create!(content: content, picture: File.open("./public/images/musclebody.jpg")) }
end

#リレーションシップ
users = User.all
following = users[0..70]

users.each do |user|
  following.each { |followed|
    user.follow(followed) unless user == followed
   }

   user.teacher = User.where( 'id >= ?', rand(User.first.id..User.last.id) ).first
end
