class AddPreviewTokenToIssue < ActiveRecord::Migration[5.2]
  def change
    add_column :issues, :preview_token, :string
  end
end
