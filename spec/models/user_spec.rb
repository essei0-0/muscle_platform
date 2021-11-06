require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create(
      name: 'test',
      email: 'test@test.com',
      password: 'password'
    )
  end
  # 名前、メールアドレス、パスワードが条件を満たしていれば有効な状態であること
  it "is valid with a valid name, email, and password" do
    expect(@user).to be_valid
  end

  #名前が空文字であれば、無効な状態であること
  it "is invalid with a blank name" do
    @user.name = ''
    @user.valid?
    expect(@user.errors[:name]).to include("を入力してください")
  end

  #名前がnilであれば、無効な状態であること
  it "is invalid without a name" do
    @user.name = nil
    @user.valid?
    expect(@user.errors[:name]).to include("を入力してください")
  end

  #名前が50文字より大きければ、無効な状態であること
  it "is invalid with a name more than 50" do
    @user.name = "a" * 51
    @user.valid?
    expect(@user.errors[:name]).to include("は50文字以内で入力してください")
  end

  #メールアドレスが空文字であれば、無効な状態であること
  it "is invalid with a blank email" do
    @user.email = ''
    @user.valid?
    expect(@user.errors[:email]).to include("を入力してください")
  end

  #メールアドレスがnilであれば、無効な状態であること
  it "is invalid without a email" do
    @user.email = nil
    @user.valid?
    expect(@user.errors[:email]).to include("を入力してください")
  end

  #メールアドレスが255文字より大きければ、無効な状態であること
  it "is invalid with email more than 255" do
    @user.email = "a" * 255 + "@test.com"
    @user.valid?
    expect(@user.errors[:email]).to include("は255文字以内で入力してください")
  end

  #パスワードが空文字であれば、無効な状態であること
  it "is invalid with a blank password" do
    @user.password = ' ' * 6
    @user.valid?
    expect(@user.errors[:password]).to include("を入力してください")
  end

  #パスワードがnilであれば、無効な状態であること
  it "is invalid without a password" do
    @user.password = nil
    @user.valid?
    expect(@user.errors[:password]).to include("を入力してください")
  end

  #パスワードが6文字より小さければ、無効な状態であること
  it "is invalid with password less than 6" do
    @user.password = 'pass'
    @user.valid?
    expect(@user.errors[:password]).to include("は6文字以上で入力してください")
  end


end
