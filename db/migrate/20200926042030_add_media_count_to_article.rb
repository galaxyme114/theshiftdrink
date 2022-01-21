class AddMediaCountToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :media_count, :integer, default: 0
  end
end
