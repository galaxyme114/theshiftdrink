class AddForwardingUrlToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :forwarding_url, :string
  end
end
