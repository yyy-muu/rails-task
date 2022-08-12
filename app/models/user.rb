class User < ApplicationRecord
  has_many :tweets, dependent: :destroy
  has_many :comments
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github]
  validates :name, presence: true
  # validates :profile_image
  validates :self_introduction, length: { maximum: 160 }

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
end
