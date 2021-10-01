class Naic < ApplicationRecord
  has_many :companies, foreign_key: "naic_id", class_name: 'Naic'
end
