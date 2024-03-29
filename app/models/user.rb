class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  validates :name, presence: true
  validates :self_introduction, length: { maximum: 160 }
  validates :uid, uniqueness: { scope: :provider }, if: :uid

  def self.find_for_github_oauth(auth)
    # 送られてきたプロバイダとuidと一致するユーザを探し、登録
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      # トークンで作成する仮パスワード
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def update_without_current_password(params)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    # params([:password])をviewのfieldから引数として受け取る
    result = update(params)

    # passwordとpassword_confirmationの値をnilにする
    clean_up_passwords
    result
  end

  def soft_delete
    update(deleted_at: Time.current)
  end

  def active_for_authentication?
    super && !deleted_at
  end

  def inactive_message
    deleted_at ? :deleted_account : super
  end

  # ユーザフォロー
  def follow(other_user)
    following << other_user
  end

  # フォロー解除
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # フォロー確認
  def following?(other_user)
    following.include?(other_user)
  end
end
