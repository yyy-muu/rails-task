require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  before do
    other_user = FactoryBot.create(:user, name: 'Other User', email: 'otheruser5@test.com')
    visit new_user_session_path
    fill_in 'メールアドレス', with: other_user.email
    fill_in 'パスワード', with: other_user.password
    click_on 'ログイン'

    click_on 'つぶやく'
    fill_in 'tweet_text', with: 'test tweet!!'
    click_on 'ツイートする'
    click_on 'ログアウト'

    visit new_user_session_path
    fill_in 'メールアドレス', with: 'testuser@test.com'
    fill_in 'パスワード', with: 'testtest'
    click_on 'ログイン'

    fill_in 'keywords', with: 'test tweet!!'
    click_button '検索'
  end

  # 他のユーザをフォローできる
  it 'user can follow other user' do
    click_link 'Other User'
    click_button 'フォロー'
    expect(page).to have_button 'フォロー解除'

  # 他のユーザをフォロー解除できる
    click_button 'フォロー解除'
    expect(page).to have_button 'フォロー'
  end
end
