class MakeUserIdNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :posts, :user_id, false
  end
end
