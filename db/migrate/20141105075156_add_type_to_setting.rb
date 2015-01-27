class AddTypeToSetting < ActiveRecord::Migration
  def change
    add_column :settings, :var_type, :integer, default: 0
  end
end
