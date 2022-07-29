class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :text
      # 参照先テーブル名の単数形+"_id, user_idを外部キーとして使用
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
