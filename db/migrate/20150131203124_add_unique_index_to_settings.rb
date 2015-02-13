class AddUniqueIndexToSettings < ActiveRecord::Migration
  def change
  	add_index :settings, :name, unique: true
  end
end
