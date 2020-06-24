User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             image_name: File.open("./public/images/muscler.jpg"))

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               image_name: File.open("./public/images/muscler.jpg"))
end

users = User.order(:created_at).take(6)
50.times do
  content =
  "ベンチプレス3セット
  ダンベルカール3セット
  レッグレイズ5セット"
  users.each { |user| user.microposts.create!(content: content, picture: File.open("./public/images/musclebody.jpg")) }
end

#リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
students = users[2..50]

following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
students.each { |student| user.student(student) }
