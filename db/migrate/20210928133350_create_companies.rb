class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :avatar_url
      t.string :business_structure, null: false, default: ''
      t.string :duns_number
      t.references :naic, foreign_key: true

      t.timestamps
    end
  end
end

