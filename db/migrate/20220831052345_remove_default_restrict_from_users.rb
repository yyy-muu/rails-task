class RemoveDefaultRestrictFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :uid, from: '', to: nil
  end
end
