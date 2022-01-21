class AddAdvertisementFlagToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :full_page_ad, :boolean
  end
end
