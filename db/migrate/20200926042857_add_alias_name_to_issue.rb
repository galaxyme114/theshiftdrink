class AddAliasNameToIssue < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :alias_name, :string, index: true
    remove_column :issues, :alias
  end
end
