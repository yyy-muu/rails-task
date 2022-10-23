require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: 'testuser@test.com'
    fill_in 'パスワード', with: 'testtest'
    click_on 'ログイン'

    click_on 'つぶやく'
    fill_in 'tweet_text', with: 'test tweet!!'
    click_on 'ツイートする'
  end

  # 投稿をいいね・いいね解除できる
  it 'user can like the tweet' do
    click_link 'test tweet!!'
    click_button '♡'
    expect(page).to have_button '♥'

    click_button '♥'
    expect(page).to have_button '♡'
  end
end
