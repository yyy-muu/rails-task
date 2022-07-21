class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  # validates :profile_image
  validates :self_introduction, length: { maximum: 160 }


  # 第2引数(*options)は廃止された
  def update_without_current_password(params)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    # params([:password])をviewのfieldから引数として受け取る
    # 保存に失敗したら例外を返す
    result = update!(params)
    
    # passwordとpassword_confirmationの値をnilにする
    clean_up_passwords
    result
  end
end
