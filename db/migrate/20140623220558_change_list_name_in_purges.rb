class ChangeListNameInPurges < ActiveRecord::Migration
  def change
    change_column :purges, :list_name, :string
  end
end
