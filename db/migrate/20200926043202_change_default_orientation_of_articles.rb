class ChangeDefaultOrientationOfArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :issues, :orientation, :string, null: false, default: "mobile"
  end
end
