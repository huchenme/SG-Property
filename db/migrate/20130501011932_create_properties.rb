class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :bedroom
      t.integer :bathroom
      t.integer :price
      t.integer :size
      t.string :sitename
      t.string :link
      t.string :phone
      t.string :agent_name
      t.string :image_url

      t.timestamps
    end
  end
end
