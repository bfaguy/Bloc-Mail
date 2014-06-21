class CreatePurges < ActiveRecord::Migration
  def change
    create_table :purges do |t|
      t.integer :list_id
      t.references :user, index: true

      t.timestamps
    end
  end
end
