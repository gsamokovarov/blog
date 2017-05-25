class AddActivatedAtToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :activated_at, :datetime
  end
end
