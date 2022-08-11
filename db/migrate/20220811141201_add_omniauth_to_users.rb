class AddOmniauthToUsers < ActiveRecord::Migration[6.0]
  # UID, providerのカラムの組み合わせに一意性を持たせ、OAuth認証でのユーザ重複を避ける
  def change
    add_column :users, :provider, :string, null: false, default: ''
    add_column :users, :uid, :string, null: false, default: ''
    add_index :users, [:uid, :provider], unique: true
  end
end
