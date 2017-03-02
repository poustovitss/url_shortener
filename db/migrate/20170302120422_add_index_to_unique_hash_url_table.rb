class AddIndexToUniqueHashUrlTable < ActiveRecord::Migration[5.0]
  def change
    add_index :urls, :unique_hash, unique: true
  end
end
