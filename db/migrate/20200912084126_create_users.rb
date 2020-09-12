class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password_digest
      t.boolean :admin, default: false
      t.string :slug

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :slug, unique: true
  end
end
