require 'rails_helper'

RSpec.describe User, type: :model do
  # 名前、メールアドレス、パスワードが条件を満たしていれば有効な状態であること
  it "is valid with a valid name, email, and password" do
    user = User.new(
      name: 'test',
      email: 'test@test.com',
      password: 'password'
    )
    expect(user).to be_valid
  end

  #名前が空文字であれば、無効な状態であること
  it "is invalid with a blank name" do
    user = User.new(name:'')

  end

  #名前がnilであれば、無効な状態であること
  it "is invalid without a name"

  #名前が50文字より大きければ、無効な状態であること
  it "is invalid with a name more than 50"

  #メールアドレスが空文字であれば、無効な状態であること
  it "is invalid with a blank email"

  #メールアドレスがnilであれば、無効な状態であること
  it "is invalid without a email"

  #メールアドレスが255文字より大きければ、無効な状態であること
  it "is invalid with email more than 255"

  #パスワードが空文字であれば、無効な状態であること
  it "is invalid with a blank password"

  #パスワードがnilであれば、無効な状態であること
  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  #パスワードが6文字より小さければ、無効な状態であること
  it "is invalid with password less than 6"


end
