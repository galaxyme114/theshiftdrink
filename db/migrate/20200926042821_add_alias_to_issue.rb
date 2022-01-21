class AddAliasToIssue < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :alias, :string, index: true
  end
end
