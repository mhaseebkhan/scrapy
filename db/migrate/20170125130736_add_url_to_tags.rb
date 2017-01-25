class AddUrlToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :url_id, :integer
    add_index  :tags, :url_id
  end
end
