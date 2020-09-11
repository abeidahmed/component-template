class CreateComponentCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :component_collections do |t|
      t.string :title, null: false

      t.timestamps
    end
    add_index :component_collections, :title
  end
end
