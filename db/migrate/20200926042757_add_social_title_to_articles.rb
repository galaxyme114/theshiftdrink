class AddSocialTitleToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :social_title, :string
  end
end
