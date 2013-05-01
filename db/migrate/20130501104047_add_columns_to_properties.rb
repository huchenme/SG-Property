class AddColumnsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :display_price, :string
  end
end
