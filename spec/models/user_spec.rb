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

  #repostされていればtrue, repostされていなければfalseを返す。
  context "reposted?" do
    let(:user) { FactoryBot.create(:user) }
    let(:reposted_post) { FactoryBot.create(:micropost, user: user) }
    let(:unreposted_post) { FactoryBot.create(:micropost, user: user) }
    let!(:repost) { FactoryBot.create(:repost, user: user, micropost: reposted_post) }
    it 'repostされている場合' do
      expect(user.reposted?(reposted_post.id)).to be_truthy
    end

    it 'repostされていない場合' do
      expect(user.reposted?(unreposted_post.id)).to be_falsey
    end
  end

  #likeされていればtrue, likeされていなければfalseを返す。
  context 'liked?' do
    let(:user) { FactoryBot.create(:user) }
    let(:liked_post) { FactoryBot.create(:micropost, user: user) }
    let(:unliked_post) { FactoryBot.create(:micropost, user: user) }
    let!(:like) { FactoryBot.create(:like, user: user, micropost: liked_post) }
    it 'likeされている場合' do
      expect(user.liked?(liked_post.id)).to be_truthy
    end

    it 'likeされていない場合' do
      expect(user.liked?(unliked_post.id)).to be_falsey
    end
  end

  describe 'create_follow_notification!' do
    let(:follower) { FactoryBot.create(:user, email: 'follower@test.com' ) }
    let(:followed) { FactoryBot.create(:user, email: 'followed@test.com' ) }
    let!(:create_notification){ follower.create_follow_notification!(followed) }

    let(:notification){ Notification.where("visitor_id = ? and visited_id = ? and action = ? ",follower.id, followed.id, 'follow') }
    it 'notificationが登録されている' do
      expect(notification).to exist
    end
  end

  describe 'create_like_notification!' do
    let(:liker) { FactoryBot.create(:user, email: 'liker@test.com' ) }
    let(:poster) { FactoryBot.create(:user, email: 'poster@test.com' ) }
    let(:micropost) { FactoryBot.create(:micropost, user: poster ) }
    let!(:create_notification){ liker.create_like_notification!(micropost) }
    let(:notification){ Notification.where("visitor_id = ? and visited_id = ? and action = ? ",liker.id, poster.id, 'like') }
    it 'notificationが登録されている' do
      expect(notification).to exist
    end
  end

  describe 'create_reply_notification!' do
    let(:replyer) { FactoryBot.create(:user, email: 'replyer@test.com' ) }
    let(:poster) { FactoryBot.create(:user, email: 'poster@test.com' ) }
    let(:micropost) { FactoryBot.create(:micropost, user: poster ) }
    let(:reply) { FactoryBot.create(:reply, micropost: micropost, user: replyer ) }
    let!(:create_notification){ replyer.create_reply_notification!(reply) }
    let(:notification){ Notification.where("visitor_id = ? and visited_id = ? and action = ? ",replyer.id, poster.id, 'reply') }
    it 'notificationが登録されている' do
      expect(notification).to exist
    end
  end
end
