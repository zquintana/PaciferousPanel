class CreateEmailAliases < ActiveRecord::Migration
  def change
    create_table :email_aliases do |t|
      t.integer :domain_id
      t.string :source
      t.string :destination

      t.timestamps
    end
  end
end
