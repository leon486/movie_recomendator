class AddActiveToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :active, :boolean
  end
end
