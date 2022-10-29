require 'rails_helper'

RSpec.describe 'Tweets', type: :system do
  before do
    @user = FactoryBot.create(:user)
    visit new_user_session_path
    fill_in 'メールアドレス', with: @user.email
    fill_in 'パスワード', with: @user.password
    click_on 'ログイン'
  end

  it 'user can tweet' do
    click_on 'つぶやく'
    expect(page).to have_content '新しいツイート'
    fill_in 'tweet_text', with: 'test tweet!!'
    click_on 'ツイートする'
    expect(page).to have_content 'ツイートを送信しました'
  end

  it 'user cannot tweet without no texts' do
    click_on 'つぶやく'
    expect(page).to have_content '新しいツイート'
    fill_in 'tweet_text', with: ''
    click_on 'ツイートする'
    expect(page).to have_content '新しいツイート'
  end

  it 'user can cancel tweet' do
    click_on 'つぶやく'
    expect(page).to have_content '新しいツイート'
    fill_in 'tweet_text', with: 'test tweet!!'
    click_on 'やっぱりやめる'
    expect(page).to have_content 'つぶやく'
  end
end
