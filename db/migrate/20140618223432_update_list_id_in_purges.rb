class UpdateListIdInPurges < ActiveRecord::Migration
  def change
    change_column :purges, :list_id, :string
  end
end
