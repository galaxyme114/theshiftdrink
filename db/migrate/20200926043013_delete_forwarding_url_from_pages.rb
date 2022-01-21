class DeleteForwardingUrlFromPages < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :forwarding_url, :string
  end
end
