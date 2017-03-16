class RemoveShortUrlFromUrl < ActiveRecord::Migration[5.0]
  def change
    remove_column :urls, :short_url, :string
  end
end
