require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end

  # 名前、メールアドレス、パスワードが条件を満たしていれば有効な状態であること
  it "is valid with a valid name, email, and password" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  #名前が空文字であれば、無効な状態であること
  it "is invalid with a blank name" do
    user = FactoryBot.build(:user_name_blank)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  #名前がnilであれば、無効な状態であること
  it "is invalid without a name" do
    user = FactoryBot.build(:user_name_nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  #名前が50文字より大きければ、無効な状態であること
  it "is invalid with a name more than 50" do
    user = FactoryBot.build(:user_name_more_than_50)
    user.valid?
    expect(user.errors[:name]).to include("は50文字以内で入力してください")
  end

  #メールアドレスが空文字であれば、無効な状態であること
  it "is invalid with a blank email" do
    user = FactoryBot.build(:user_email_blank)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  #メールアドレスがnilであれば、無効な状態であること
  it "is invalid without a email" do
    user = FactoryBot.build(:user_email_nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  #メールアドレスが255文字より大きければ、無効な状態であること
  it "is invalid with email more than 255" do
    user = FactoryBot.build(:user_email_more_than_255)
    user.valid?
    expect(user.errors[:email]).to include("は255文字以内で入力してください")
  end

  #パスワードが空文字であれば、無効な状態であること
  it "is invalid with a blank password" do
    user = FactoryBot.build(:user_password_blank)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  #パスワードがnilであれば、無効な状態であること
  it "is invalid without a password" do
    user = FactoryBot.build(:user_password_nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  #パスワードが6文字より小さければ、無効な状態であること
  it "is invalid with password less than 6" do
    user = FactoryBot.build(:user_password_less_than_6)
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end


end
