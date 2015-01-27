class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.string :name
      t.string :alias
      t.integer :user_id
      t.integer :status
      t.integer :ip_id

      t.timestamps
    end
  end
end
