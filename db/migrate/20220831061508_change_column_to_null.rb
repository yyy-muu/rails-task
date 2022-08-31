class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :users, :uid, true
  end

  def down
    change_column_null :users, :uid, false
  end
end
