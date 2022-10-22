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

  it 'user can comment on the tweet' do
    click_link 'test tweet!!'
    expect(page).to have_content 'test tweet!!'
    click_on 'コメント'
    expect(page).to have_content '新しいコメント'
    fill_in 'comment_text', with: 'test comment!!'
    click_on 'コメントする'
    expect(page).to have_content 'コメントを送信しました'
  end

  it 'user cannot comment without no texts' do
    click_link 'test tweet!!'
    click_on 'コメント'
    expect(page).to have_content '新しいコメント'
    fill_in 'comment_text', with: ''
    click_on 'コメントする'
    expect(page).to have_content '新しいコメント'
  end

  it 'user can cancel comment' do
    click_link 'test tweet!!'
    click_on 'コメント'
    expect(page).to have_content '新しいコメント'
    fill_in 'comment_text', with: 'test another comment!!'
    click_on 'やっぱりやめる'
    expect(page).to have_content 'つぶやく'
  end
end
