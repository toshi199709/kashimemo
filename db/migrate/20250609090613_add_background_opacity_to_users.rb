class AddBackgroundOpacityToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :background_opacity, :integer, default: 100, null: false
  end
end
