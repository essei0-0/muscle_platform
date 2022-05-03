class User < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one :active_deep_relationships, class_name:  "DeepRelationship",
                                   foreign_key: "student_id",
                                   dependent:   :destroy

  has_many :passive_deep_relationships, class_name: "DeepRelationship",
                                foreign_key: "teacher_id",
                                dependent:   :destroy
  has_one :teacher, through: :active_deep_relationships
  has_many :students, through: :passive_deep_relationships

  has_many :health_records, dependent: :destroy
  has_many :meal_records, dependent: :destroy
  has_many :reposts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  mount_uploader :image_name, ImagenameUploader

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
              format: { with: VALID_EMAIL_REGEX },
              uniqueness: { case_sensitive: false }
  has_secure_password

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  validate  :image_name_size

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def User.trend_feed
    Micropost.limit(10)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # ユーザーのステータスフィードを返す
  def feed
    Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # ユーザーを弟子にする
  def student(other_user)
    students << other_user
  end

  # 現在のユーザーが弟子であればtrueを返す
  def student?(other_user)
    students.include?(other_user)
  end


  # ユーザーの弟子をやめる
  def not_teacher(other_user)
    active_deep_relationships.destroy
  end

  def convert_birthday_into_age
    if !birthday.nil?
    (Date.today.strftime("%Y%m%d").to_i - self.birthday.strftime("%Y%m%d").to_i) / 10000
    end
  end

  def reposted?(post_id)
    reposts.exists?(micropost_id: post_id)
  end

  def liked?(post_id)
    likes.exists?(micropost_id: post_id)
  end

  def create_follow_notification!(user)
    temp = Notification.where("visitor_id = ? and visited_id = ? and action = ? ",self.id, user.id, 'follow')
    if temp.blank?
      notification = active_notifications.new(
        visited_id: user.id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def create_like_notification!(post)
    # すでに「いいね」されているか検索
    temp = Notification.where("visitor_id = ? and visited_id = ? and micropost_id = ? and action = ? ", self.id, post.user_id, post.id, 'like')
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = active_notifications.new(
        micropost_id: post.id,
        visited_id: post.user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_reply_notification!(reply)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Reply.where('micropost_id = ? and user_id <> ?', reply.micropost_id, self.id).ids.uniq
    temp_ids.each do |temp_id|
      save_reply_notification!(reply, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_reply_notification!(reply, reply.micropost.user_id) if temp_ids.blank?
  end

  def save_reply_notification!(reply, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = active_notifications.new(
      micropost_id: reply.micropost_id,
      reply_id: reply.id,
      visited_id: visited_id,
      action: 'reply'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  private
  # アップロードされた画像のサイズをバリデーションする
  def image_name_size
    if image_name.size > 5.megabytes
      errors.add(:image_name, "should be less than 5MB")
    end
  end
end
