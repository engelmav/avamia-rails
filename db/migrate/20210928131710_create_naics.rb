class CreateNaics < ActiveRecord::Migration[6.1]
  def change
    create_table :naics do |t|
      t.string :code, null: false
      t.string :title, null: false, default: ''
      t.text :description, null: false, default: ''
      t.timestamps
    end
    add_index :naics, :code, unique: true
  end
end
