class AddAliasIndexToUsers < ActiveRecord::Migration
  def change
  	add_index :users, :alias, unique: true
  end
end
