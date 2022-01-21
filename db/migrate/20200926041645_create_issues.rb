class CreateIssues < ActiveRecord::Migration[5.2]
  def change
    create_table :issues do |t|
      t.string :friendly_id, index: true

      t.string :title,  null: false, default: ""
      t.string :number, null: false, default: "", index: true
      t.string :role,   null: false, default: "Issue"

      t.integer :articles_count, default: 0

      t.string :orientation, null: false, default: "Portrait"

      t.date :published_on
      t.references :creator, index: true

      t.integer :articles_count, default: 0

      t.timestamps null: false
    end
  end
end
