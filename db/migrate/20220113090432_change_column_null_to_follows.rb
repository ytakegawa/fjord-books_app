class ChangeColumnNullToFollows < ActiveRecord::Migration[6.1]
  def change
    change_column_null :follows, :followed_id, null: false
    change_column_null :follows, :follower_id, null: false
  end
end
