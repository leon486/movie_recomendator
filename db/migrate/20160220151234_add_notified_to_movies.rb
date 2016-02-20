class AddNotifiedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :notified, :boolean
  end
end
