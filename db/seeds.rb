User.create!(name:  "アイレット太郎",
             email: "power@muscle.com",
             password:              "password",
             password_confirmation: "password",
             bio: "筋肉は裏切らない！",
             url: "https://www.iret.co.jp/",
             tel: "080-xx1-4649")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+2}@muscle.com"
  password = "password"
  birthday = Date.new(1987, 1 + (n%12), 1 + (n % 30))
  gender = 1 + (n % 2)
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               bio: "筋肉は裏切らない！",
               url: "https://www.google.com",
               tel: "080-xx#{n+2}-4649",
               birthday: birthday,
               gender: gender)

end

users = User.order(:created_at).take(5)
10.times do
  content =
  "筋トレ楽しい！"
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.order(:created_at).take(5)
31.times do |n|
  height = 170.6
  weight = 65.5 - (n / 5.0)
  fat = (15 + (n / 15.0)).round(1)
  day = DateTime.now - n.day
  users.each { |user| user.health_records.create!(height: height, weight: weight, fat: fat , measured_at: day) }
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
