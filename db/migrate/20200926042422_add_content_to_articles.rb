class AddContentToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :content, :text
    remove_column :pages, :content, :text
  end
end
