class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :title, null: false
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
    add_index :pages, :title
  end
end
