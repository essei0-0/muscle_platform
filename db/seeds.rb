User.create!(name:  "アイレット太郎",
             email: "power@muscle.com",
             password:              "password",
             password_confirmation: "password",
             bio: "筋肉は裏切らない！",
             url: "https://www.iret.co.jp/",
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
               bio: "筋肉は裏切らない！",
               url: "https://www.google.com",
               tel: "080-xx#{n+2}-4649")

end

users = User.order(:created_at).take(50)
10.times do
  content =
  "筋トレ楽しい！"
  users.each { |user| user.microposts.create!(content: content) }
end

#リレーションシップ
users = User.all

users.each do |user|
  following = User.find(User.pluck(:id)).sample(50)
  following.each { |followed|
    unless user == followed
      user.follow(followed)
    end
   }

   teacher = User.find(User.pluck(:id).sample)
   unless (user.teacher && user.student == teacher)
     user.teacher = teacher
   end
end
