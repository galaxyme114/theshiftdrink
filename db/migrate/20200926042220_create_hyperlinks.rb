class CreateHyperlinks < ActiveRecord::Migration[5.2]
  def change
    create_table :hyperlinks do |t|
      t.string :source_url
      t.string :label_color
      
      t.integer :coord_y
      t.integer :coord_x
      t.integer :coord_w
      t.integer :coord_h

      t.references :page, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
