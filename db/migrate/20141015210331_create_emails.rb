class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :domain_id
      t.string :password
      t.string :email

      t.timestamps
    end
  end
end
