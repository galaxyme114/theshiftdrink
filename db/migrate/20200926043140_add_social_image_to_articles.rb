class AddSocialImageToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :social_thumbnail, :string
  end
end
