class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :friendly_id, index: true

      t.string :title, null: false, default: ""
      t.string :image

      t.text :content, null: false, default: ""

      t.integer :position
      t.integer :master_position

      t.integer :issue_id, index: true

      t.references :article, index: true
      t.references :creator, index: true

      t.timestamps null: false
    end
  end
end
