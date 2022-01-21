class AddTitlePicToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :title_pic, :string
  end
end
