class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      
      t.timestamps null: false
    end
  end
end
