RSpec.configure do |config|
# GUIなし、ヘッドレスブラウザでE2Eテストを実行する設定
  config.before(:each, type: :system) do
    # driven_by(:selenium_chrome)
    driven_by :selenium_chrome_headless
  end
end
