class CreatePageCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :page_collections do |t|
      t.string :title, null: false

      t.timestamps
    end
    add_index :page_collections, :title
  end
end
