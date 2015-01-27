class AddDescripToSshKey < ActiveRecord::Migration
  def change
    add_column :ssh_keys, :descrip, :string
  end
end
