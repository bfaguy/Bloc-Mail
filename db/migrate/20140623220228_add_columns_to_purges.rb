class AddColumnsToPurges < ActiveRecord::Migration
  def change
    add_column :purges, :list_name, :string, default: 0
    add_column :purges, :errors_count, :integer, default: 0
  end
end
