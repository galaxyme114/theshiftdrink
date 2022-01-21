class AddUniqueIdentifierToHyperlinks < ActiveRecord::Migration[5.2]
  def change
    add_column :hyperlinks, :uuid, :string, index: true
  end
end
