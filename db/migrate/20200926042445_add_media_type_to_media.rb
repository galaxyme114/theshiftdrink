class AddMediaTypeToMedia < ActiveRecord::Migration[5.2]
  def change
    add_column :media, :media_type, :string
  end
end
