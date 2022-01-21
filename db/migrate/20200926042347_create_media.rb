class CreateMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :media do |t|
      t.string :asset
      t.string :override_url
      t.string :friendly_id, index: true

      t.integer :position
      t.integer :issue_id, index: true

      t.references :article, index: true
      t.references :creator, index: true

      t.timestamps null: false
    end
  end
end
