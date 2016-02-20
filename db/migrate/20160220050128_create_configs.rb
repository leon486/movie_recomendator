class CreateConfigs < ActiveRecord::Migration
  def change
    create_table :configs do |t|
      t.string :parameter
      t.string :value
      t.string :description

      t.timestamps null: false
    end
  end
end
