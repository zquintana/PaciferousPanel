class CreateSshKeys < ActiveRecord::Migration
  def change
    create_table :ssh_keys do |t|
      t.integer :user_id
      t.text :key

      t.timestamps
    end
  end
end
