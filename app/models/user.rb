class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  # validates :profile_image
  validates :self_introduction, length: { maximum: 160 }

  def update_without_current_password(params)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    # params([:password])をviewのfieldから引数として受け取る
    # 保存に失敗した場合、registration_controllerのupdateメソッドでフラッシュメッセージを出す
    result = update(params)

    # passwordとpassword_confirmationの値をnilにする
    clean_up_passwords
    result
  end


  # instead of deleting, indicate the user requested a delete & timestamp it
  def soft_delete
    update_attributes(deleted_at: Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !deleted_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !deleted_at ? super : :deleted_account
  end
end
