class AddProccessingToImages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :image_processing, :boolean, null: false, default: false
    add_column :media, :asset_processing, :boolean, null: false, default: false
  end
end
