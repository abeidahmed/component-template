class CreateComponents < ActiveRecord::Migration[6.0]
  def change
    create_table :components do |t|
      t.string :title, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :components, :title
  end
end
