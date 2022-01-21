class AddIsAdvertisementFlagToPages < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :is_advertisement, :boolean, default: false
  end
end
