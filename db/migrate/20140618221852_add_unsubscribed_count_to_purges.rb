class AddUnsubscribedCountToPurges < ActiveRecord::Migration
  def change
    add_column :purges, :unsubscribed_count, :integer
  end
end
