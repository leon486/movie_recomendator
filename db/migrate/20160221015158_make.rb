class Make < ActiveRecord::Migration
  def change
    change_column :movies, :active, :boolean, default: true
  end
end
