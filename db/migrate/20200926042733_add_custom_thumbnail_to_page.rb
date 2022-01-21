class AddCustomThumbnailToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :advertisement_thumb, :string
  end
end
