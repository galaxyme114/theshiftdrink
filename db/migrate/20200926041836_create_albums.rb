class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      
      t.timestamps null: false
    end
  end
end
