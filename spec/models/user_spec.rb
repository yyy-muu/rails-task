require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'positive for signup' do
    # ユーザ名・メールアドレス・パスワードが存在すれば有効であること
    it 'is valid with a name, an email and password' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  describe 'negative for signup' do
    # ユーザー名がない場合、無効になること
    it 'is invalid without a name' do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include("#{user.name}を入力してください")
    end

    # メールアドレスがない場合、無効になること
    it 'is invalid without an email' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("#{user.email}を入力してください")
    end

    # メールアドレスが重複した場合、無効になること
    it 'is invalid when email is dupulicated' do
      FactoryBot.create(:user, email: 'dummy@test.com')
      user = FactoryBot.build(:user, email: 'dummy@test.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'positive for profile' do
    # プロフィール文が160字以内であれば有効であること
    it 'is valid with self introduction 160 or less' do
      user = FactoryBot.build(:user, self_introduction: 'プロフィール見てくださってありがとうございます。')
      expect(user).to be_valid
    end

    # 拡張子がpng, gif, jpegの場合、プロフィール画像をアップロードできること
    it 'is valid with profile image when file type are png, gif and jpeg' do
      user = FactoryBot.build(:user)
      user.profile_image = fixture_file_upload('/files/test_icon.png')
      user.profile_image.save
      expect(user.profile_image).to be_valid
    end

    # プロフィール画像が未設定の場合、ダミー画像が設定されnilでないこと
    it 'is valid with dummy profile image when unsetting the image' do
      user = FactoryBot.build(:user)
      user.save
      expect(user.profile_image).not_to eq nil
    end
  end

  describe 'negative for profile' do
    # プロフィール文が161字以上の場合、無効になること
    it 'is invalid with self introduction 161 or more' do
      user = FactoryBot.build(
        :user,
        self_introduction: 'この文章はダミーです。161文字あります。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れています。この文章はダミーです。文字の大きさ、量、字間、行間等を確認するために入れてい'
      )
      expect(user).to be_invalid
    end
  end
end
