require 'rails_helper'

RSpec.describe 'Users', type: :system do
  # ユーザ登録できる
  it 'can create new account' do
    visit root_path
    click_on 'サインアップ'
    fill_in 'ユーザーネーム', with: 'test'
    fill_in 'メールアドレス', with: 'testtest@test.com'
    fill_in 'パスワード', with: 'testtest'
    fill_in 'パスワード（確認用）', with: 'testtest'
    click_on '今すぐはじめる'
    expect(page).to have_content 'アカウント登録が完了しました。'
  end

  # 退会（ユーザ削除）できる
  it 'can logical delete an account' do
    visit root_path
    click_on 'サインアップ'
    fill_in 'ユーザーネーム', with: 'test'
    fill_in 'メールアドレス', with: 'testtest@test.com'
    fill_in 'パスワード', with: 'testtest'
    fill_in 'パスワード（確認用）', with: 'testtest'
    click_on '今すぐはじめる'

    click_on 'test'
    click_on '退会する'
    expect(page).to have_content 'ログインもしくはアカウント登録してください。'

    # 同じアカウント情報で再ユーザ登録はできない
    visit root_path
    click_on 'サインアップ'
    fill_in 'ユーザーネーム', with: 'test'
    fill_in 'メールアドレス', with: 'testtest@test.com'
    fill_in 'パスワード', with: 'testtest'
    fill_in 'パスワード（確認用）', with: 'testtest'
    click_on '今すぐはじめる'
    expect(page).to have_content 'すでに存在します'
  end

  # ログイン・ログアウトできる
  it 'user can login then logout' do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_on 'ログイン'
    expect(page).to have_content 'ログインしました。'

    click_on 'ログアウト'
    expect(page).to have_content 'ログインもしくはアカウント登録してください。'
  end
end
