class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :friendly_id, index: true
      
      t.string :title, default: "", null: false
      t.integer :position

      t.boolean :custom_thumbnail

      t.references :issue,   index: true
      t.references :creator, index: true

      t.integer :pages_count,  default: 0
      
      t.timestamps null: false
    end
  end
end
